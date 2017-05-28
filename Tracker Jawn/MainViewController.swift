//
//  MainViewController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/14/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, NumberpadTouchDelegate {
    var expenseCalendar : ExpenseCalendar
    
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
        view.addSubview(numberpad)
        view.setNeedsUpdateConstraints()
        view.backgroundColor = Constants.BACKGROUND_COLOR
        updateDailyTotal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateDailyTotal()
    }
    
    override func updateViewConstraints() {
        imageViewConstraints()
        dailyUsageLabelConstraints()
        dailyUsageCountConstraints()
        userInputConstraints()
        numberpadConstraints()
        super.updateViewConstraints()
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
    
    // ~~~~ SUBVIEWS ~~~~ //
    lazy var imageView: UIImageView! = {
        let view = UIImageView()
        view.image = UIImage(named: "tracker-jawn-logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = UIViewContentMode.scaleAspectFit
        return view
    }()
    
    lazy var dailyUsageLabel : UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Today's Spending:"
        return view
    }()
    
    lazy var dailyUsageCount : UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 24.0)
        view.textAlignment = .center
        view.text = ""
        return view
    }()
    
    lazy var userInputLabel : InputLabelView! = {
        let view = InputLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var numberpad : UIView! = {
        var view = NumberPad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.touchDelegate = self
        return view
    }()

    
    // ~~~~ CONSTRAINTS ~~~~ //
    func imageViewConstraints() {
        
        NSLayoutConstraint(
            item: imageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: imageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.9,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: imageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
    }
    
    func dailyUsageLabelConstraints() {
        NSLayoutConstraint(
            item: dailyUsageLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: dailyUsageLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: imageView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -30.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: dailyUsageLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        
    }
    
    func dailyUsageCountConstraints() {
        NSLayoutConstraint(
            item: dailyUsageCount,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: dailyUsageCount,
            attribute: .top,
            relatedBy: .equal,
            toItem: dailyUsageLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 5.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: dailyUsageCount,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        
    }
    
    func userInputConstraints() {
        NSLayoutConstraint(
            item: userInputLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: userInputLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: dailyUsageCount,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: userInputLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1.0,
            constant: -200)
            .isActive = true
        
        NSLayoutConstraint(
            item: userInputLabel,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 40.0)
            .isActive = true
    }
    
    func numberpadConstraints() {
        NSLayoutConstraint(
            item: numberpad,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: numberpad,
            attribute: .top,
            relatedBy: .equal,
            toItem: userInputLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: numberpad,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1.0,
            constant: -80.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: numberpad,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -60.0)
            .isActive = true
    }
}

protocol NumberpadTouchDelegate {
    func handleTouch(tag : Int) // ...or class methods
}
