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
    var ledger : [TJWeek]
    var cdContext : NSManagedObjectContext
    
    init(context : NSManagedObjectContext) {
        cdContext = context
        ledger = [TJWeek]()
        fetchDailyExpenses()
        let _ = todaysTJDate()
    }
    
    /**
     Loads all dates and expenses from the CoreDataManager and adds them to this instance
     of the ExpenseCalendar
     */
    func fetchDailyExpenses() {
        
        let fetchRequest : NSFetchRequest<TJWeek> = TJWeek.fetchRequest()
        
        cdContext.performAndWait {
            do {
                let weeks = try fetchRequest.execute()
                print("Recovered weeks: \(weeks.count)")
                if (weeks.count == 0) { return }
                self.ledger = weeks.sorted(by: { (w1: TJWeek, w2: TJWeek) -> Bool in
                    return w1.mondayDate().compare(w2.mondayDate()) == ComparisonResult.orderedDescending})
                
            } catch {
                print("Error recovering TJDates from persistent store")
                print("\(error): \(error.localizedDescription)")
            }
        }
    }
    
    /**
     Adds expense to todays date
     */
    func submitInput(amount : Double) {
        let todayTJDate = todaysTJDate()
        todayTJDate.createAndAddExpense(amount: amount)
    }
    
    /**
     Returns the TJDate corresponding to today. Also ensures that such a date exists in the ledger
     and that all previous dates exist as well
     - returns : the TJDate corresponding to today
     */
    func todaysTJDate() -> TJDate {
        if (ledger.count == 0) {
            print("No existing data entries")
            return createTJDateForToday()
        }
        let thisWeek = ledger[0].getDescendingDates()
        let recentTJDate = thisWeek[0]
        let today = NSDate().noonNormalized()
        let isEqual = recentTJDate.date!.isEqual(today.toDate())
        if (!isEqual) {
            let daysSince = recentTJDate.daysSinceToday()
            if (daysSince == 1) {
                return createTJDateForToday()
            }
            else {
                for i in (1...daysSince).reversed() {
                    var week = ledger[0]
                    let lastDay = ledger[0].getDescendingDates()[0]
                    if (lastDay.date!.dayOfWeek() == 6) {
                        week = TJWeek(context: cdContext)
                        ledger.insert(week, at: 0)
                    }
                    let newDate = TJDate(context: cdContext)
                    newDate.date = NSDate.priorDate(daysSinceToday: i - 1).noonNormalized()
                    week.addToDates(newDate)
                }
                return ledger[0].getDescendingDates()[0]
            }
        }
        return ledger[0].getDescendingDates()[0]
    }
    
    /**
     Sums the expenses for today
     - returns: the total amount spent today
     */
    func getTodaysTotal() -> Double {
        let todayTJDate = todaysTJDate()
        return todayTJDate.sumExpenses()
    }
    
    /**
     Adds a new TJDate object to the legder collection in this instance of expenseCalendar
     - returns: the TJDate object added to the ledger
     */
    func createTJDateForToday() -> TJDate {
        let date = TJDate(context: cdContext)
        date.date = NSDate().noonNormalized()
        if (ledger.count == 0) {
            let week = TJWeek(context: cdContext)
            ledger.insert(week, at: 0)
            week.addToDates(date)
        }
        else if (date.date!.dayOfWeek() == 0) {
            let week = TJWeek(context: cdContext)
            ledger.insert(week, at: 0)
            week.addToDates(date)
        }
        else {
            let week = ledger[0]
            week.addToDates(date)
        }
        return date
    }
    
    func movingAverage(numDays : Int) -> Double {
        let _ = todaysTJDate()
        var weekNum = 0
        var sum = 0.0
        var count = 0
        while (count != numDays) {
            if (weekNum >= ledger.count) {
                break;
            }
            let week = ledger[weekNum]
            for d in week.getDescendingDates() {
                if (count == numDays) {
                    break;
                }
                else {
                    sum += d.sumExpenses()
                    count += 1
                }
            }
            if (count == numDays) {
                break;
            }
            weekNum += 1
        }
        return sum / Double(count)
    }
    
    func numWeeks() -> Int {
        return ledger.count
    }
    
    func weekOf(offset: Int) -> TJWeek? {
        guard (offset < ledger.count) else { return nil }
        return ledger[offset]
    }
    
    func deleteDate(week : Int, day: Int) -> Bool {
        let tjDate = dateFor(week: week, day: day)
        guard (tjDate != nil) else { return false }
        CoreDataManager.getInstance().managedObjectContext.delete(tjDate!)
        ledger[week].removeFromDates(tjDate!)
        if (ledger[week].dates!.count == 0) {
            ledger.remove(at: week)
        }
        return true
    }
    
    func dateFor(week : Int, day : Int) -> TJDate? {
        guard (week < ledger.count) else { return nil }
        let daysOfWeek = ledger[week].getDescendingDates()
        guard (day < daysOfWeek.count) else { return nil }
        return daysOfWeek[day]
    }
    
    func dates(approxBufferSize : Int) -> [TJDate] {
        let _ = todaysTJDate()
        let numWeeks = Int(ceil(Double(approxBufferSize) / 7.0))
        var dates = [TJDate]()
        for i in 0...numWeeks {
            if (i >= ledger.count) {
                break
            }
            dates += ledger[i].getDescendingDates()
        }
        return dates
    }

}
