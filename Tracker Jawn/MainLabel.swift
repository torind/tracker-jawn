//
//  GradientLabel.swift
//  Tracker Jawn
//
//  Created by Torin on 6/4/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class MainLabel: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let rect = bounds
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 12.0, height: 12.0)).cgPath
        
        let outline = CAShapeLayer()
        outline.path = path
        outline.fillColor = UIColor(hex: 0xDBDBDB).cgColor
        self.layer.addSublayer(outline)
    }
    
}
