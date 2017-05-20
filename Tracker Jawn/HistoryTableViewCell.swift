//
//  HistoryTableViewCell.swift
//  Tracker Jawn
//
//  Created by Torin on 5/20/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation
import UIKit

class HistoryTableViewCell: UITableViewCell {
    let dateLabel = UILabel()
    let amountLabel = UILabel()
    final let DATE_PROPORTION = CGFloat(0.75)
    final let DATE_PADDING = CGFloat(25.0)
    final let AMOUNT_PADDING = CGFloat(25.0)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateLabel.frame.size = CGSize(width: (frame.width * DATE_PROPORTION) - DATE_PADDING,
                                      height: frame.height)
        dateLabel.frame.origin = CGPoint(x: DATE_PADDING,
                                         y: 0.0)
        
        amountLabel.frame.size = CGSize(width: frame.width * (1-DATE_PROPORTION) - AMOUNT_PADDING,
                                        height: frame.height)
        
        amountLabel.frame.origin = CGPoint(x: frame.width * DATE_PROPORTION,
                                           y: 0.0)
        amountLabel.textAlignment = NSTextAlignment.right
        self.addSubview(dateLabel)
        self.addSubview(amountLabel)
    }
    
    func setDate(date : NSDate) {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM - d"
        let dateString = formatter.string(from: date.toDate())
        dateLabel.text = dateString
    }
    
    func setAmount(amount : Double) {
        let displayAmount = String(format: "%.02f", amount)
        amountLabel.text = "$\(displayAmount)"
    }
}
