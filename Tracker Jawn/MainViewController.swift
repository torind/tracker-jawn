//
//  MainViewController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/14/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, NumberpadTouchDelegate, UIGestureRecognizerDelegate {
    var expenseCalendar : ExpenseCalendar
    let that = self
    var state : MAIN_STATE = .amountInput
    
    init(expenseCalendar : ExpenseCalendar) {
        self.expenseCalendar = expenseCalendar
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("MainViewController has no NSCoding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(dailyUsageLabel)
        view.addSubview(dailyUsageCount)
        view.addSubview(userInputLabel)
        
        view.backgroundColor = Constants.BACKGROUND_COLOR
        updateDailyTotal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateDailyTotal()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let iv_hPad = CGFloat(20.0)
        let iv_tPad = CGFloat(10.0)
        let ivWidth = view.frame.width - 2 * iv_hPad
        imageView.frame = CGRect(x: iv_hPad, y: UIApplication.shared.statusBarFrame.height + iv_tPad,
                                 width: ivWidth, height: ivWidth * 0.388)
        
        let dul_tPad = CGFloat(40.0)
        dailyUsageLabel.frame = CGRect(x: 0.0, y: imageView.frame.height + dul_tPad,
                                       width: view.frame.width, height: 24.0)
        
        let duc_tPad = CGFloat(2.0)
        dailyUsageCount.frame = CGRect(x: 0.0, y: dailyUsageLabel.frame.maxY + duc_tPad,
                                       width: view.frame.width, height: 30.0)
        
        let uil_hPad = CGFloat(90.0)
        let uil_tPad = CGFloat(15.0)
        userInputLabel.frame = CGRect(x: uil_hPad, y: dailyUsageCount.frame.maxY + uil_tPad,
                                      width: view.frame.width - 2 * uil_hPad, height: 40.0)
        if (state == .amountInput) {
            tagView.removeFromSuperview()
            view.addSubview(numberpad)
            let np_tPad = CGFloat(20.0)
            let np_hPad = CGFloat(30.0)
            numberpad.frame = CGRect(x: np_hPad,
                                     y: userInputLabel.frame.maxY + np_tPad,
                                     width: view.frame.width - 2 * np_hPad,
                                     height: view.frame.height * 0.465)
        }
        else if (state == .tagInput) {
            numberpad.removeFromSuperview()
            view.addSubview(tagView)
            let np_tPad = CGFloat(20.0)
            let np_hPad = CGFloat(30.0)
            tagView.frame = CGRect(x: np_hPad,
                                     y: userInputLabel.frame.maxY + np_tPad,
                                     width: view.frame.width - 2 * np_hPad,
                                     height: view.frame.height * 0.465)
        }
    }
    
    func updateDailyTotal() {
        dailyUsageCount.text = Util.formatCurrency(amount: expenseCalendar.getTodaysTotal())
    }
    
    // ~~~~ HANDLER METHODS ~~~~ //
    func handleTouch(tag : Int) {
        let chars = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", ""]
        switch (tag) {
        case 9 :
            userInputLabel.backspace()
        case 11 :
            expenseCalendar.submitInput(amount: userInputLabel.getDoubleForInput())
            userInputLabel.resetInput()
            updateDailyTotal()
        default :
            userInputLabel.processInput(char: chars[tag])
        }
    }
    
    func handleSwipe(_ gr : UIGestureRecognizer) {
        if let sgr = gr as? UISwipeGestureRecognizer {
            if (sgr.direction == .left) {
                self.state = .tagInput
            }
            else if (sgr.direction == .right){
                self.state = .amountInput
            }
            view.setNeedsLayout()
        }
    }
    
    // ~~~~ SUBVIEWS ~~~~ //
    lazy var imageView: UIImageView! = {
        let view = UIImageView()
        view.image = UIImage(named: "tracker-jawn-logo")
        view.contentMode = UIViewContentMode.scaleAspectFit
        return view
    }()
    
    lazy var dailyUsageLabel : UILabel! = {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeue", size: 20.0)
        view.text = "Today's Spending:"
        view.textAlignment = .center
        return view
    }()
    
    lazy var dailyUsageCount : UILabel! = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 24.0)
        view.textAlignment = .center
        view.text = ""
        return view
    }()
    
    lazy var userInputLabel : InputLabelView! = {
        let view = InputLabelView()
        return view
    }()
    
    lazy var numberpad : UIView! = {
        var view = NumberPad()
        view.touchDelegate = self
        let sgr = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        sgr.delegate = self
        sgr.direction = .left
        view.addGestureRecognizer(sgr)
        return view
    }()
    
    lazy var tagView : TagInputView = {
        var view = TagInputView()
        let sgr = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        sgr.delegate = self
        sgr.direction = .right
        view.addGestureRecognizer(sgr)
        return view
    }()

}

protocol NumberpadTouchDelegate {
    func handleTouch(tag : Int) // ...or class methods
}

enum MAIN_STATE {
    case amountInput
    case tagInput
}
