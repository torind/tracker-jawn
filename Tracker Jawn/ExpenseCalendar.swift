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
    var ledger : [NSDate : TJDate]
    var cdContext : NSManagedObjectContext
    
    init(context : NSManagedObjectContext) {
        cdContext = context
        ledger = [NSDate : TJDate]()
        fetchDailyExpenses()
    }
    
    /**
     Loads all dates and expenses from the CoreDataManager and adds them to this instance
     of the ExpenseCalendar
     */
    func fetchDailyExpenses() {
        print("Fetching from persistent store")
        let fetchRequest : NSFetchRequest<TJDate> = TJDate.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(TJDate.date),
                                                            ascending: false)]
        cdContext.performAndWait {
            do {
                let dates = try fetchRequest.execute()
                print ("Dates fetched: \(dates.count)")
                for d in dates {
                    let nsDate = d.date
                    guard (nsDate != nil) else { continue }
                    //self.ledger[nsDate!] = d
                }
            } catch {
                print("Error recovering TJDates from persistent store")
                print("\(error): \(error.localizedDescription)")
            }
        }
    }
    
    
    /**
     Gets the display amount
     - returns: the display amount
     */
    func getDisplayAmount() -> String {
        return parseInputChars()
    }
    
    /**
     Deletes the last inputed characters
     - returns: the new display amount
     */
    func backspace() -> String {
        if (inputChars.characters.count > 0) {
            let index = inputChars.index(inputChars.endIndex, offsetBy: -1)
            inputChars = inputChars.substring(to: index)
        }
        return parseInputChars()
    }
    
    /**
     Adds expense to todays date and resets input
     - returns: the new display amount equal to an empty string
     */
    func submitInput() -> String {
        var todayTJDate = ledger[ExpenseCalendar.todaysDate()]
        if (todayTJDate == nil) {
            todayTJDate = createTJDateForToday()
        }
        let expenseDouble = Double(inputChars)! / 100
        todayTJDate!.createAndAddExpense(amount: expenseDouble)
        inputChars = ""
        return parseInputChars()
    }
    
    /**
     Adds input to the input characters and returns the display amount
     - parameter char: the character that was input
     - returns: the corresponfing delay amount
     */
    func processInput(char : String) -> String {
        inputChars = inputChars + char
        return parseInputChars()
    }
    
    /**
     Sums the expenses for today
     - returns: the total amount spent today
     */
    func getTodaysTotal() -> Double {
        var todayTJDate = ledger[ExpenseCalendar.todaysDate()]
        if (todayTJDate == nil) {
            todayTJDate = createTJDateForToday()
        }
        return todayTJDate!.sumExpenses()
    }
    
    /**
     Parses the input characters as a dollar amount a.k.a. a double with two decimals
     - returns: the string to be displayed for the given input
     */
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
    
    /**
     Adds a new TJDate object to the legder collection in this instance of expenseCalendar
     - returns: the TJDate object added to the ledger
     */
    func createTJDateForToday() -> TJDate {
        print("Creating a new date for today")
        let date = TJDate(context: cdContext)
        date.date = NSDate().noonNormalized()
        ledger[ExpenseCalendar.todaysDate()] = date
        return date
    }
    
    /**
     Creates a NSDate object containing today's date with time set to 00:00:00
     - returns: the NSDate object
     */
    static func todaysDate() -> NSDate {
        return NSDate().noonNormalized()
    }

}
