//
//  HistoryViewController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/14/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var myTableView: UITableView!
    private var sections: NSArray = ["This Week","Last Week","Two Weeks Ago"]
    private var expenseCalendar : ExpenseCalendar
    private var tableView : UITableView?
    
    init(expenseCalendar : ExpenseCalendar) {
        self.expenseCalendar = expenseCalendar
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("MainViewController has no NSCoding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView!.register(HistoryTableViewCell.self, forCellReuseIdentifier: "SpendingHistoryCell")
        tableView!.dataSource = self
        tableView!.delegate = self
        self.view.addSubview(tableView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView!.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return expenseCalendar.numWeeks()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseCalendar.weekOf(offset: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingHistoryCell", for: indexPath as IndexPath) as! HistoryTableViewCell
        let tjDate = expenseCalendar.weekOf(offset: indexPath.section)[indexPath.row]
        cell.setDate(date: tjDate.date!)
        cell.setAmount(amount : tjDate.sumExpenses())
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(sections[section])"
    }
}
