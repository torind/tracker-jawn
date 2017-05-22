//
//  SingleDayHistoryTableViewController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/21/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class SingleDayTableViewController: UITableViewController {
    var date : TJDate
    var expenses : [TJExpense] = [TJExpense]()
    
    init(date : TJDate) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
        setExpenses()
        setTitle()
        tableView.register(DailyHistoryTableViewCell.self,
                           forCellReuseIdentifier: "DailyHistoryTableCell")
        self.tableView.allowsMultipleSelectionDuringEditing = false;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("SingleDayTableViewController has no NSCoding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setExpenses()
        tableView!.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyHistoryTableCell", for: indexPath) as! DailyHistoryTableViewCell
        cell.setAmount(amount: expenses[indexPath.row].amount)
        cell.setTime(date: expenses[indexPath.row].createdAt!)
        return cell
    }
    
    func setExpenses() {
        if (date.expenses != nil) {
            expenses = date.expenses!.sortedArray( using: [NSSortDescriptor(key: #keyPath(TJExpense.createdAt), ascending: false)]) as! [TJExpense]
        }
        else {
            expenses = [TJExpense]()
        }
    }
    
    func setTitle() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        let dateString = formatter.string(from: date.date!.toDate())
        self.title = dateString
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let expense = expenses[indexPath.row]
            CoreDataManager.getInstance().managedObjectContext.delete(expense)
            date.removeFromExpenses(expense)
            setExpenses()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }    
    }
 
}
