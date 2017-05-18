//
//  BalanceHistoryModel.swift
//  Tracker Jawn
//
//  Created by Torin on 5/16/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ExpenseCalendar {
    var inputChars = ""
    var ledger : [NSDate: TJDate]
    var cdContext : NSManagedObjectContext?
    
    init() {
        ledger = [NSDate: TJDate]()
    }
    
    func fetchDailyExpenses() {
        print("Fetching from persistent store")
        let fetchRequest : NSFetchRequest<TJDate> = TJDate.fetchRequest()
        cdContext?.performAndWait {
            do {
                let dates = try fetchRequest.execute()
                print ("Dates fetched: \(dates.count)")
                for d in dates {
                    let nsDate = d.date
                    guard (nsDate != nil) else { continue }
                    self.ledger[nsDate!] = d
                }
            } catch {
                print("Error recovering TJDates from persistent store")
                print("\(error): \(error.localizedDescription)")
            }
        } ?? print("Could not fetch TJDates because context was not initialized")
    }
    
    func getDisplayAmount() -> String {
        return parseInputChars()
    }
    
    func backspace() -> String {
        if (inputChars.characters.count > 0) {
            let index = inputChars.index(inputChars.endIndex, offsetBy: -1)
            inputChars = inputChars.substring(to: index)
        }
        return parseInputChars()
    }
    
    func submitInput() -> String {
        var todayTJDate = ledger[todaysDate()]
        if (todayTJDate == nil) {
            todayTJDate = createTJDateForToday()
        }
        let expenseDouble = Double(inputChars)! / 100
        todayTJDate!.createAndAddExpense(amount: expenseDouble)
        inputChars = ""
        return parseInputChars()
    }
    
    func processInput(char : String) -> String {
        inputChars = inputChars + char
        return parseInputChars()
    }
    
    func getTodaysTotal() -> Double {
        var todayTJDate = ledger[todaysDate()]
        if (todayTJDate == nil) {
            todayTJDate = createTJDateForToday()
        }
        return todayTJDate!.sumExpenses()
    }
    
    func parseInputChars() -> String {
        let displayAmount : String
        let inputLength = inputChars.characters.count
        switch(inputLength) {
        case 0 :
            displayAmount = "$ .  "
        case 1 :
            displayAmount = "$ . " + inputChars
        case 2 :
            displayAmount = "$ ." + inputChars
        default :
            let index = inputChars.index(inputChars.endIndex, offsetBy: -2)
            let decimals = inputChars.substring(from: index)
            let dollars = inputChars.substring(to: index)
            displayAmount = "$" + dollars + "." + decimals
        }
        return displayAmount
    }
    
    func createTJDateForToday() -> TJDate {
        print("Creating a new date for today")
        let date = todaysTJDate()
        ledger[todaysDate()] = date
        return date
    }
    
    func todaysDate() -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        let dateComps = dateString.components(separatedBy: " ")
        let zeroedDateString = dateComps[0] + " 00:00:00"
        let zeroedDate = dateFormatter.date(from: zeroedDateString)!
        let zeroedNSDate = NSDate(timeIntervalSince1970: zeroedDate.timeIntervalSince1970)
        return zeroedNSDate
    }
    
    func todaysTJDate() -> TJDate {
        let tjDate = TJDate(context: cdContext!)
        tjDate.date = todaysDate()
        return tjDate
    }

}
