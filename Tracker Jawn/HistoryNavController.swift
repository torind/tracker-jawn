//
//  HistoryNavViewController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/21/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class HistoryNavController: UINavigationController, UINavigationControllerDelegate {
    var expenseCalendar : ExpenseCalendar?
    var historyViewController : HistoryTableViewController?
    var controllerDate : TJDate?
    
    init(expenseCalendar : ExpenseCalendar) {
        self.expenseCalendar = expenseCalendar
        historyViewController = HistoryTableViewController(expenseCalendar: self.expenseCalendar!)
        historyViewController!.title = "History"
        super.init(rootViewController: historyViewController!)
        delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("HistoryNavViewController has no NSCoding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = Constants.NAV_COLOR
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        if (self.viewControllers.count > 1) {
            let backButtonImage = UIImage(named: "back-button")!
                .withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            let backButton = UIBarButtonItem(image: backButtonImage,
                                             style: UIBarButtonItemStyle.plain,
                                             target: self,
                                             action: #selector(backButtonPressed(_:)))
            viewController.navigationItem.setLeftBarButton(backButton, animated: false)
        }
        if let controller = viewController as? SingleDayTableViewController {
            controllerDate = controller.date
            let plusButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(plusButtonPressed(_:)))
            controller.navigationItem.setRightBarButton(plusButton, animated: false)
        }
    }
    
    func plusButtonPressed(_ param : Bool) {
        if (controllerDate != nil) {
            let addController = AddExpenseToDayViewController(date: controllerDate!)
            self.pushViewController(addController, animated: false)
        }
    }
    
    func backButtonPressed(_ param : Bool) {
        popViewController(animated: true)
    }
    
    func addShadow() {
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        navigationBar.layer.shadowRadius = 1.0
        navigationBar.layer.shadowOpacity = 0.8
        navigationBar.layer.masksToBounds = false
    }
    
}
