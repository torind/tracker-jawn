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
    
    lazy var dailyUsageView = ProfileStatView("TODAY:")
    lazy var weeklyUsageView = ProfileStatView("7 DAY AVG:")
    lazy var monthlyUsageView = ProfileStatView("30 DAY AVG:")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.BACKGROUND_COLOR
        addSubview(dailyUsageView)
        addSubview(weeklyUsageView)
        addSubview(monthlyUsageView)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(frame.height)
        print(bounds.height)
        let sectionH = frame.height / 8
        let views = [dailyUsageView, weeklyUsageView, monthlyUsageView]
        let yPoints = [frame.height-4*sectionH, frame.height-3*sectionH, frame.height-2*sectionH]
        let heights = [sectionH, sectionH, sectionH]
        
        var i = 0
        for v in views {
            v.frame.size = CGSize(width: frame.width, height: heights[i])
            v.frame.origin = CGPoint(x: CGFloat(0.0), y: yPoints[i])
            i += 1
        }
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

}
