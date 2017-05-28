//
//  MainTabBarController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/14/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit
import CoreData

class MainTabBarController: UITabBarController {
    private let coreDataManager : CoreDataManager
    private var mainViewController : MainViewController?
    private var historyNavController : HistoryNavController?
    private var profileNavController : ProfileNavController?
    private var expenseCalendar : ExpenseCalendar
    
    init() {
        coreDataManager = CoreDataManager.getInstance()
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
        historyNavController = HistoryNavController(expenseCalendar : expenseCalendar)
        profileNavController = ProfileNavController(expenseCalendar: expenseCalendar)
        
        
        let controllers : [UIViewController] = [mainViewController!, profileNavController!, historyNavController!]
        
        self.tabBar.barTintColor = Constants.NAV_COLOR
        
        self.viewControllers = controllers
        
        mainViewController!.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "icon-home"),
            tag: 1)
        
        profileNavController!.tabBarItem = UITabBarItem(
            title: "Me",
            image: UIImage(named: "icon-me"),
            tag: 3)
        
        historyNavController!.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(named: "icon-history"),
            tag: 2)

    }


}
