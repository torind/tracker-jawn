//
//  Date.swift
//  Tracker Jawn
//
//  Created by Torin on 5/18/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation

extension Date {
    func toNSDate() -> NSDate {
        return NSDate(timeIntervalSince1970: self.timeIntervalSince1970)
    }
}
