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
    var ledger : [[TJDate]]
    var cdContext : NSManagedObjectContext
    
    init(context : NSManagedObjectContext) {
        cdContext = context
        ledger = [[TJDate]]()
        fetchDailyExpenses()
    }
    
    /**
     Loads all dates and expenses from the CoreDataManager and adds them to this instance
     of the ExpenseCalendar
     */
    func fetchDailyExpenses() {
        var daysThisWeek = Util.currentDayOfWeek()
        
        let fetchRequest : NSFetchRequest<TJDate> = TJDate.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(TJDate.date),
                                                            ascending: false)]
        cdContext.performAndWait {
            do {
                let dates = try fetchRequest.execute()
                print ("Dates fetched: \(dates.count)")
                if (dates.count == 0) { return } 
                var week = [TJDate]()
                for d in dates {
                    week.append(d)
                    daysThisWeek -= 1
                    if (daysThisWeek == 0) {
                        print("Appending week \(self.ledger.count + 1)")
                        self.ledger.append(week)
                        week = [TJDate]()
                        daysThisWeek = 7
                    }
                }
                if (daysThisWeek != 0) {
                    print("Appending week \(self.ledger.count + 1)")
                    self.ledger.append(week)
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
        ledgerHasTodayCheck()
        let todayTJDate = ledger[0][0]
        let expenseDouble = Double(inputChars)! / 100
        todayTJDate.createAndAddExpense(amount: expenseDouble)
        inputChars = ""
        return parseInputChars()
    }
    
    /**
     Ensures that the ledger contains an entry for today's date, otherwise it creates one
     */
    func ledgerHasTodayCheck() {
        if (ledger.count == 0) {
            print("No existing data entries")
            createTJDateForToday()
            return
        }
        let recentTJDate = ledger[0][0]
        let today = NSDate().noonNormalized()
        let isEqual = recentTJDate.date!.isEqual(today.toDate())
        if (!isEqual) {
            createTJDateForToday()
        }
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
        ledgerHasTodayCheck()
        let todayTJDate = ledger[0][0]
        return todayTJDate.sumExpenses()
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
    func createTJDateForToday() {
        print("Creating a new date for today")
        let date = TJDate(context: cdContext)
        date.date = ExpenseCalendar.todaysDate()
        if (ledger.count == 0) {
            let week = [date]
            ledger.append(week)
            return
        }
        if (Util.currentDayOfWeek() == 0) {
            let week = [date]
            ledger.insert(week, at: 0)
        }
        else {
            let week = ledger[0]
            ledger.insert(week, at: 0)
        }
    }
    
    /**
     Creates a NSDate object containing today's date with time set to 00:00:00
     - returns: the NSDate object
     */
    static func todaysDate() -> NSDate {
        return NSDate().noonNormalized()
    }
    
    func numWeeks() -> Int {
        return ledger.count
    }
    
    func weekOf(offset: Int) -> [TJDate] {
        return ledger[offset]
    }

}
