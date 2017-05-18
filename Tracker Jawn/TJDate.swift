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
}
