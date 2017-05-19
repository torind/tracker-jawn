//
//  TJDate.swift
//  Tracker Jawn
//
//  Created by Torin on 5/17/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation

extension TJDate {
    func sumExpenses() -> Double {
        let expenseSet = self.expenses
        guard (expenseSet != nil) else { return 0.0 }
        let expenses = expenseSet!.allObjects as! [TJExpense]
        var sum = 0.0
        for e in expenses {
            sum += e.amount
        }
        return sum
    }
    
    func createAndAddExpense(amount : Double) {
        let expense = TJExpense(context: self.managedObjectContext!)
        expense.amount = amount
        self.addToExpenses(expense)
    }
    
    func daysSinceToday() -> Int {
        let calendar = NSCalendar.current
        let today = NSDate().noonNormalized()
        let components = calendar.dateComponents([Calendar.Component.day],
                                                 from: self.date!.toDate(),
                                                 to: today.toDate())
        if (components.date == nil) {
            fatalError("Failed to get number of days since today for date \(self.date)")
        }
        return components.day!
    }
}
