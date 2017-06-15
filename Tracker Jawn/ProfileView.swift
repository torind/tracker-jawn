//
//  ProfileView.swift
//  Tracker Jawn
//
//  Created by Torin on 5/25/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit
import Charts


class ProfileView: UIView {
    let DIVIDER_HEIGHT = CGFloat(1.0)
    let DIVIDER_H_PADDING = CGFloat(20.0)
    let PADDING_HEIGHT = CGFloat(40.0)
    var gradient : CAGradientLayer!
    
    var controller : ProfileViewController?
    
    lazy var dailyUsageView = ProfileStatView("TODAY:")
    lazy var weeklyUsageView = ProfileStatView("7 DAY AVG:")
    lazy var monthlyUsageView = ProfileStatView("30 DAY AVG:")
    
    lazy var chart : LineChartView = {
        let c = LineChartView(frame: self.frame)
        
        c.dragEnabled = true
        c.dragDecelerationEnabled = true
        c.doubleTapToZoomEnabled = false
        c.highlightPerTapEnabled = false
        c.highlightPerDragEnabled = false
        c.scaleXEnabled = true
        c.scaleYEnabled = false
        c.drawGridBackgroundEnabled = false
        c.isOpaque = false
        c.gridBackgroundColor = UIColor.clear
        
        let xAxis = c.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.axisLineColor = UIColor.white
        xAxis.axisLineWidth = 2.0
        xAxis.labelTextColor = UIColor.white
        xAxis.valueFormatter = ProfileXAxisFormatter()
        
        let lyAxis = c.leftAxis
        lyAxis.drawGridLinesEnabled = false
        lyAxis.axisMinimum = 0.0
        lyAxis.axisLineColor = UIColor.white
        lyAxis.axisLineWidth = 2.0
        lyAxis.labelTextColor = UIColor.white
        lyAxis.spaceTop = 0.3
        lyAxis.labelPosition = .insideChart
        lyAxis.valueFormatter = ProfileYAxisFormatter()
        lyAxis.drawAxisLineEnabled = false
        
        c.legend.enabled = false
        c.chartDescription?.text = ""
        c.rightAxis.enabled = false
        c.autoScaleMinMaxEnabled = true
        return c
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0x34495E)
        createGradientOverlay()
        addSubview(chart)
        addSubview(dailyUsageView)
        addSubview(weeklyUsageView)
        addSubview(monthlyUsageView)
    }
    
    convenience init(frame: CGRect, controller: ProfileViewController) {
        self.init(frame: frame)
        self.controller = controller
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
        
        let cPadding = [0.0, 20.0, 0.0, 0.0] //left, top, right, bottom
        let visibleHeight = controller?.getVisibleHeight() ?? frame.height
        
        let chartHeight = visibleHeight / 2
        let statHeight = (visibleHeight - chartHeight) / 3
        
        chart.frame = CGRect(x: CGFloat(cPadding[0]),
                             y: CGFloat(cPadding[1]),
                             width: frame.width - CGFloat(cPadding[0] + cPadding[2]),
                             height: chartHeight - CGFloat(cPadding[1] + cPadding[3]))
        
        dailyUsageView.frame = CGRect(x: 0.0, y: chartHeight,
                                      width: frame.width, height: statHeight)
        
        weeklyUsageView.frame = CGRect(x: 0.0, y: chartHeight + statHeight,
                                       width: frame.width, height: statHeight)
        
        monthlyUsageView.frame = CGRect(x: 0.0, y: chartHeight + 2 * statHeight,
                                       width: frame.width, height: statHeight)
    }
    
    class LineDivider : UIView {
        let top = UIView()
        let bottom = UIView()
        init() {
            super.init(frame: CGRect.zero)
            top.backgroundColor = UIColor(hex: 0xBEBDB3)
            bottom.backgroundColor = UIColor(hex: 0xE6E3D7)
            addSubview(top)
            addSubview(bottom)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            top.frame.origin = CGPoint(x: CGFloat(0.0), y: CGFloat(0.0))
            top.frame.size = CGSize(width: frame.width, height: frame.height/2)
            bottom.frame.origin = CGPoint(x: CGFloat(0.0), y: frame.height/2)
            bottom.frame.size = CGSize(width: frame.width, height: frame.height/2)
        }
    }
    
    func setDailyField(text : String) {
        dailyUsageView.setField(text: text)
    }
    
    func setWeeklyField(text : String) {
        weeklyUsageView.setField(text: text)
    }
    
    func setMonthlyField(text : String) {
        monthlyUsageView.setField(text: text)
    }
    
    func setLineChartData(data : LineChartData) {
        chart.data = data
        chart.setVisibleXRangeMinimum(7.0)
        chart.notifyDataSetChanged()
    }
    
    func createGradientOverlay() {
        gradient = CAGradientLayer()
        let light = UIColor.black.withAlphaComponent(0.0).cgColor
        let dark = UIColor.black.withAlphaComponent(0.2).cgColor
        gradient.colors = [light, dark]
        self.layer.addSublayer(gradient)
    }
    
    func resetViewport() {
        let numPointsToShow = 7.0
        if (chart.data == nil) {
            return
        }
        else {
            let totalPoints = Double(chart.data!.entryCount)
            let scaleX = totalPoints / numPointsToShow
            chart.zoom(scaleX: CGFloat(scaleX), scaleY: 1.0, x: 0.0, y: 0.0)
            chart.moveViewToX(totalPoints - numPointsToShow)
        }
    }
}
