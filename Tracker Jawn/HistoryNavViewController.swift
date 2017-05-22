//
//  HistoryNavViewController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/21/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class HistoryNavViewController: UINavigationController, UINavigationControllerDelegate {
    
    var expenseCalendar : ExpenseCalendar?
    var historyViewController : HistoryTableViewController?
    
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        if (self.viewControllers.count > 1) {
            viewController.navigationItem.setLeftBarButton(backButtonFactory(), animated: false)
        }
    }
    
    func backButtonFactory() -> UIBarButtonItem {
        let backButtonImage = UIImage(named: "back-button")!
                                .withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backButtonImage,
                                         style: UIBarButtonItemStyle.plain,
                                         target: self,
                                         action: #selector(backButtonPressed(_:)))
        return backButton
    }
    
    func backButtonPressed(_ param : Bool) {
        popViewController(animated: true)
    }
    
}
