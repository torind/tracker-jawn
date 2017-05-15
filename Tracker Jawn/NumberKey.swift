//
//  NumberKey.swift
//  Tracker Jawn
//
//  Created by Torin on 5/15/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit
import CoreGraphics

class NumberKey: UIView {
    let label = UILabel()
    let circleLayer = CAShapeLayer()
    
    init(frame: CGRect, label: String) {
        super.init(frame: frame)
        addBehavior(text : label)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero, label: "Label")
    }
    
    convenience init(label : String) {
        self.init(frame: CGRect.zero, label: label)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addBehavior(text : String) {
        label.text = text
        let fontDescriptor = UIFontDescriptor(fontAttributes: [UIFontWeightTrait : 1.5])
        label.font = UIFont(descriptor: fontDescriptor, size: 40)
        label.textAlignment = .center
        label.textColor = Constants.THEME_COLOR
        self.addSubview(label)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 50,y: 50), radius: 50, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = Constants.THEME_COLOR.cgColor
        circleLayer.lineWidth = 3.0
        
        self.layer.addSublayer(circleLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        label.frame.size = CGSize(width: frame.width, height: frame.height)
        label.frame.origin = CGPoint(x: 0, y: 0)
        
        circleLayer.frame.size = CGSize(width: frame.width, height: frame.height)
        circleLayer.frame.origin = CGPoint(x: 0, y: 0)
        drawCircleContainer()
    }
    
    // draw new circle container based on frame dimensions
    func drawCircleContainer() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.width / 2,y: frame.height / 2), radius: frame.width / 2, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        circleLayer.path = circlePath.cgPath
    }
}
