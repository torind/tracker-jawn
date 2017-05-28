//
//  ProfileNavController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/22/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit
import QuartzCore

class ProfileNavController: UINavigationController, UINavigationControllerDelegate {
    private var expenseCalendar : ExpenseCalendar?
    private var profileViewController : ProfileViewController?
    
    init(expenseCalendar : ExpenseCalendar) {
        self.expenseCalendar = expenseCalendar
        self.profileViewController = ProfileViewController(expenseCalendar: expenseCalendar)
        super.init(rootViewController: self.profileViewController!)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ProfileNavController has no NSCoding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = Constants.NAV_COLOR
        addShadow()
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
    }
    
    func backButtonPressed(_ param : Bool) {
        popViewController(animated: true)
    }
    
    func addShadow() {
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        navigationBar.layer.shadowRadius = 3.0
        navigationBar.layer.shadowOpacity = 0.8
        navigationBar.layer.masksToBounds = false
    }

}
