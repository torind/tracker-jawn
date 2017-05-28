//
//  StatsViewController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/16/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    private var expenseCalendar : ExpenseCalendar
    private var profileView : ProfileView?
    
    init(expenseCalendar : ExpenseCalendar) {
        self.expenseCalendar = expenseCalendar
        super.init(nibName: nil, bundle: nil)
        self.title = "Usage Profile"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ProfileViewController has no NSCoding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView = ProfileView(frame: view.frame)
        view.addSubview(profileView!)
    }
    
    override func viewDidAppear(_ animated : Bool) {
        super.viewDidAppear(animated)
        profileView!.setDailyField(text:
            Util.formatCurrency(amount: expenseCalendar.getTodaysTotal()))
        profileView!.setWeeklyField(text:
            Util.formatCurrency(amount: expenseCalendar.movingAverage(numDays: 7)))
        profileView!.setMonthlyField(text:
            Util.formatCurrency(amount: expenseCalendar.movingAverage(numDays: 30)))
    }

}
