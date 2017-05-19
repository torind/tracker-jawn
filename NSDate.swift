//
//  NSDate.swift
//  Tracker Jawn
//
//  Created by Torin on 5/18/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation

extension NSDate {
    func toDate() -> Date {
        return Date(timeIntervalSince1970: self.timeIntervalSince1970)
    }
    
    func noonNormalized() -> NSDate {
        let calendar = NSCalendar.current
        let normalizedDate = calendar.date(bySettingHour: 12, minute: 00, second: 00, of: calendar.startOfDay(for: self.toDate()))
        if (normalizedDate == nil) {
            fatalError("Could not normalize date \(self)")
        }
        return normalizedDate!.toNSDate()
    }
}
