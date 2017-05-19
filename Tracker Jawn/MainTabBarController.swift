//
//  MainTabBarController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/14/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    private let coreDataManager : CoreDataManager
    private var mainViewController : MainViewController?
    private var historyViewController : HistoryViewController?
    private var statsViewController : StatsViewController?
    private var expenseCalendar : ExpenseCalendar
    
    init() {
        coreDataManager = CoreDataManager(modelName: "TrackerJawn")
        expenseCalendar = ExpenseCalendar(context: coreDataManager.managedObjectContext)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("MainTabBarController has no NSCoding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initalize View Controllers
        mainViewController = MainViewController(expenseCalendar : expenseCalendar)
        historyViewController = HistoryViewController(expenseCalendar : expenseCalendar)
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
