//
//  StatsViewController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/16/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit
import Charts

class ProfileViewController: UIViewController {
    private var expenseCalendar : ExpenseCalendar
    private var profileView : ProfileView!
    
    init(expenseCalendar : ExpenseCalendar) {
        self.expenseCalendar = expenseCalendar
        super.init(nibName: nil, bundle: nil)
        self.title = "Usage Profile"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ProfileViewController has no NSCoding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView = ProfileView(frame: view.frame, controller: self)
        view.addSubview(profileView!)
    }
    
    override func viewDidAppear(_ animated : Bool) {
        super.viewDidAppear(animated)
        profileView!.setDailyField(text:
            Util.formatCurrency(amount: expenseCalendar.getTodaysTotal()))
        profileView!.setWeeklyField(text:
            Util.formatCurrency(amount: expenseCalendar.movingAverage(numDays: 7)))
        profileView!.setMonthlyField(text:
            Util.formatCurrency(amount: expenseCalendar.movingAverage(numDays: 30)))
        setViewChartData()
        profileView.resetViewport()
    }
    
    func setViewChartData() {
            var entries = [ChartDataEntry]()
            let dates = expenseCalendar.dates(approxBufferSize: 100).reversed()
            var j = 0
            for i in dates.indices {
                let entry = ChartDataEntry(x: Double(j), y: dates[i].sumExpenses())
                entries.append(entry)
                j += 1
            }
        
            let dataSet = LineChartDataSet(values: entries, label: nil)
            dataSet.axisDependency = .left
            dataSet.mode = .cubicBezier
            dataSet.drawValuesEnabled = false
            dataSet.drawCirclesEnabled = false
            dataSet.drawFilledEnabled = true
            dataSet.lineWidth = 0.0
            dataSet.fillColor = UIColor(hexAlpha: 0x84D5EAFF)
            profileView.setLineChartData(data: LineChartData(dataSets: [dataSet]))
    }
    
    func getVisibleHeight() -> CGFloat {
        var height = view.frame.height
        if (self.navigationController != nil) {
            let size = self.navigationController!.navigationBar.frame.size;
            height -= size.height
        }
    
        return height
    }

}
