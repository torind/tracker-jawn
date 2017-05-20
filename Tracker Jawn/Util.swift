//
//  Util.swift
//  Tracker Jawn
//
//  Created by Torin on 5/20/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation


class Util {
    
    /**
     Gets current day of the week, starting from monday as 0
     - returns : integer corresponding to the day of the week
    */
    static func currentDayOfWeek() -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([Calendar.Component.weekday],
                                                 from: NSDate().toDate())
        guard (components.weekday != nil) else {
            fatalError("CurrentDayofWeek returned a nil value")
        }
        let day = components.weekday! - 1
        print("Current weekday: \(day)")
        return day
    }
}
