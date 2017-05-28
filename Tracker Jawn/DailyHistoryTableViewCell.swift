//
//  DailyHistoryTableViewCell.swift
//  Tracker Jawn
//
//  Created by Torin on 5/21/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class DailyHistoryTableViewCell: UITableViewCell {
    let timeLabel = UILabel()
    let descLabel = UILabel()
    let amountLabel = UILabel()
    final let TIME_PROPORTION = CGFloat(0.35)
    final let DESC_PROPORTION = CGFloat(0.40)
    final let TIME_PADDING = CGFloat(25.0)
    final let AMOUNT_PADDING = CGFloat(25.0)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = Constants.CELL_COLOR
        
        //Time Label Frame
        let timeLabelWidth = (frame.width * TIME_PROPORTION) - TIME_PADDING
        timeLabel.frame.size = CGSize(width: timeLabelWidth,
                                      height: frame.height)
        timeLabel.frame.origin = CGPoint(x: TIME_PADDING,
                                         y: 0.0)
        
        //Description Label Frame
        let descLabelWidth = frame.width * DESC_PROPORTION
        descLabel.frame.size = CGSize(width: descLabelWidth,
                                      height: frame.height)
        descLabel.frame.origin = CGPoint(x: timeLabelWidth + TIME_PADDING,
                                         y: 0.0)
        
        ///Amount Label Frame
        let amountLabelWidth = frame.width * (1 - TIME_PROPORTION - DESC_PROPORTION) - AMOUNT_PADDING
        amountLabel.frame.size = CGSize(width: amountLabelWidth,
                                        height: frame.height)
        
        amountLabel.frame.origin = CGPoint(x: timeLabelWidth + descLabelWidth + TIME_PADDING,
                                           y: 0.0)
        
        amountLabel.textAlignment = NSTextAlignment.right
        descLabel.textAlignment = NSTextAlignment.center
        
        self.addSubview(timeLabel)
        self.addSubview(descLabel)
        self.addSubview(amountLabel)
    }
    
    func setTime(date : NSDate) {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let timeString = formatter.string(from: date.toDate())
        timeLabel.text = timeString
    }
    
    func setDesc(desc : String) {
        descLabel.text = desc
    }
    
    func setAmount(amount : Double) {
        let displayAmount = String(format: "%.02f", amount)
        amountLabel.text = "$\(displayAmount)"
    }


}
