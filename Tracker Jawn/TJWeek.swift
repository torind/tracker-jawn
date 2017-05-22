//
//  TJWeek.swift
//  Tracker Jawn
//
//  Created by Torin on 5/22/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation

extension TJWeek {
    
    func getDescendingDates() -> [TJDate] {
        let dateComparator = { (p1 : Any, p2 : Any) -> ComparisonResult in
            let tjD1 = p1 as! TJDate
            let tjD2 = p2 as! TJDate
            let d1 = tjD1.date!.toDate()
            let d2 = tjD2.date!.toDate()
            return d2.compare(d1) }
        let days = self.dates!.sortedArray(comparator: dateComparator) as! [TJDate]
        return days
    }
    
    func mondayDate() -> Date {
        let week = getDescendingDates()
        return week[week.count - 1].date!.toDate()
    }
}
