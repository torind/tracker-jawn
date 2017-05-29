//
//  ChartFormatters.swift
//  Tracker Jawn
//
//  Created by Torin on 5/28/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation
import Charts

class ProfileYAxisFormatter: NSObject, IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if (value == 0.0) {
            return ""
        }
        else {
            return "$" + String(format: "%.0f", value)
        }
    }
}

class ProfileXAxisFormatter: NSObject, IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let daysSince = axis!.axisMaximum - value
        let date = NSDate.priorDate(daysSinceToday: Int(daysSince))
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date.toDate())
    }
}
