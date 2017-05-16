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
    var text : String
    let XPADDING = NumberPad.XPADDING
    let YPADDING = NumberPad.YPADDING
    
    init(frame: CGRect, label: String) {
        text = label
        super.init(frame: frame)
        addText(text : label)
        addOutline()
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
    
    func addText(text: String) {
        label.text = text
        let fontDescriptor = UIFontDescriptor(fontAttributes: [UIFontWeightTrait : 1.5])
        label.font = UIFont(descriptor: fontDescriptor, size: 40)
        label.textAlignment = .center
        label.textColor = Constants.THEME_COLOR
        self.addSubview(label)
    }
    
    func addOutline() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 50,y: 50), radius: 50, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = Constants.THEME_COLOR.cgColor
        circleLayer.lineWidth = 3.0
        
        self.layer.addSublayer(circleLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame.size = CGSize(width: frame.width - CGFloat(2 * XPADDING), height: frame.height - CGFloat(2 * YPADDING))
        label.frame.origin = CGPoint(x: XPADDING, y: YPADDING)
        
        circleLayer.frame.size = CGSize(width: frame.width - CGFloat(2 * XPADDING), height: frame.height - CGFloat(2 * YPADDING))
        circleLayer.frame.origin = CGPoint(x: XPADDING, y: YPADDING)
        drawCircleContainer()
    }
    
    // draw new circle container based on frame dimensions
    func drawCircleContainer() {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: circleLayer.frame.width / 2,y: circleLayer.frame.height / 2),
            radius: (circleLayer.frame.height / 2) - CGFloat(YPADDING),
            startAngle: 0, endAngle: CGFloat(M_PI * 2),
            clockwise: true)
        circleLayer.path = circlePath.cgPath
    }
}
