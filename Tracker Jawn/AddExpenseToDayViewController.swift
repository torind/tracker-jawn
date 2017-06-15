//
//  AddExpenseToDayViewController.swift
//  Tracker Jawn
//
//  Created by Torin on 6/11/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class AddExpenseToDayViewController: UIViewController, NumberpadTouchDelegate {
    var date : TJDate!
    
    init(date : TJDate) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
        self.view.addSubview(dateLabel)
        self.view.addSubview(dailyUsageLabel)
        self.view.addSubview(dailyUsageCount)
        self.view.addSubview(userInputLabel)
        self.view.addSubview(numberpad)
        setDate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("MainViewController has no NSCoding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDailyTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        let dateString = formatter.string(from: date.date!.toDate())
        dateLabel.text = dateString
    }
    
    
    func updateDailyTotal() {
        dailyUsageCount.text = Util.formatCurrency(amount: date.sumExpenses())
    }
    
    override func viewDidLayoutSubviews() {
        let dl_tPad = CGFloat(25.0)
        dateLabel.frame = CGRect(x: 0.0, y: dl_tPad,
                                 width: view.frame.width, height: 28.0)
        
        let dul_tPad = CGFloat(15.0)
        dailyUsageLabel.frame = CGRect(x: 0.0, y: dateLabel.frame.maxY + dul_tPad,
                                       width: view.frame.width, height: 24.0)
        
        let duc_tPad = CGFloat(2.0)
        dailyUsageCount.frame = CGRect(x: 0.0, y: dailyUsageLabel.frame.maxY + duc_tPad,
                                       width: view.frame.width, height: 30.0)
        
        let uil_hPad = CGFloat(90.0)
        let uil_tPad = CGFloat(15.0)
        userInputLabel.frame = CGRect(x: uil_hPad, y: dailyUsageCount.frame.maxY + uil_tPad,
                                      width: view.frame.width - 2 * uil_hPad, height: 40.0)
        
        let np_tPad = CGFloat(20.0)
        let np_hPad = CGFloat(30.0)
        numberpad.frame = CGRect(x: np_hPad,
                                 y: userInputLabel.frame.maxY + np_tPad,
                                 width: view.frame.width - 2 * np_hPad,
                                 height: view.frame.height * 0.52)
    }
    
    // ~~~~ Handler Methods ~~~~ //
    func handleTouch(tag : Int) {
        let chars = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", ""]
        switch (tag) {
        case 9 :
            userInputLabel.backspace()
        case 11 :
            date.createAndAddExpense(amount: userInputLabel.getDoubleForInput())
            userInputLabel.resetInput()
            updateDailyTotal()
        default :
            userInputLabel.processInput(char: chars[tag])
        }
    }
    
    
    // ~~~~ Subviews ~~~~ //
    
    lazy var dateLabel : UILabel! = {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeue-Bold", size: 28.0)
        view.textAlignment = .center
        return view
    }()
    
    lazy var dailyUsageLabel : UILabel! = {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeue", size: 20.0)
        view.text = "Day's Spending:"
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
        return view
    }()

}
