//
//  Factories.swift
//  Tracker Jawn
//
//  Created by Torin on 5/22/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation
import UIKit

class UtilFactories {
    
    static func backButtonFactory(selector : Selector) -> UIBarButtonItem {
        let backButtonImage = UIImage(named: "back-button")!
            .withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backButtonImage,
                                         style: UIBarButtonItemStyle.plain,
                                         target: self,
                                         action: selector)
        return backButton
    }
}
