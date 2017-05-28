//
//  UIColor.swift
//  Tracker Jawn
//
//  Created by Torin on 5/27/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: Int) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(hexAlpha: Int) {
        self.init(
            red: CGFloat((hexAlpha >> 24) & 0xFF) / 255,
            green: CGFloat((hexAlpha >> 16) & 0xFF) / 255,
            blue: CGFloat(hexAlpha >> 8 & 0xFF) / 255,
            alpha: CGFloat(hexAlpha & 0xFF) / 255
        )
    }
}
