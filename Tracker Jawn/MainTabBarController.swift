//
//  MainTabBarController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/14/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    private let coreDataManager = CoreDataManager(modelName: "TrackerJawn")
    private var mainViewController : MainViewController?
    private var historyViewController : HistoryViewController?
    private var statsViewController : StatsViewController?
    private var expenseCalendar = ExpenseCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenseCalendar.cdContext = coreDataManager.managedObjectContext
        print("Bouta fetch daily expenses")
        expenseCalendar.fetchDailyExpenses()
        
        //Initalize View Controllers
        mainViewController = MainViewController(dataManager: coreDataManager,
                                                expenseCalendar : expenseCalendar)
        historyViewController = HistoryViewController()
        statsViewController = StatsViewController()
        
        
        let controllers : [UIViewController] = [mainViewController!, statsViewController!, historyViewController!]
        
        self.viewControllers = controllers
        
        mainViewController!.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "icon-home"),
            tag: 1)
        
        statsViewController!.tabBarItem = UITabBarItem(
            title: "Me",
            image: UIImage(named: "icon-me"),
            tag: 3)
        
        historyViewController!.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(named: "icon-history"),
            tag: 2)

    }


}
