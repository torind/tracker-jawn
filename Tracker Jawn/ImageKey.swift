//
//  SendKey.swift
//  Tracker Jawn
//
//  Created by Torin on 5/16/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class ImageKey: UIView {
    let circleLayer = CAShapeLayer()
    let imageView = UIImageView()
    let XPADDING = NumberPad.XPADDING
    let YPADDING = NumberPad.YPADDING
    let IMAGE_PADDING : CGFloat = 20.0
    var imageName : String = ""
    
    init(frame: CGRect, imgName : String) {
        super.init(frame: frame)
        self.imageName = imgName
        addOutline()
        addImage()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero, imgName: "")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
    override func layoutSubviews() {
        circleLayer.frame.size = CGSize(width: frame.width - CGFloat(2 * XPADDING), height: frame.height - CGFloat(2 * YPADDING))
        circleLayer.frame.origin = CGPoint(x: XPADDING, y: YPADDING)
        drawCircleContainer()
        addShadow()
        
        imageView.frame.size = CGSize(width: frame.width - 2 * IMAGE_PADDING, height: frame.height  - 2 * IMAGE_PADDING)
        imageView.frame.origin = CGPoint(x: IMAGE_PADDING, y: IMAGE_PADDING)
    }
    
    func addImage() {
        imageView.image = UIImage(named: self.imageName)
        imageView.contentMode = .scaleAspectFit
        
        self.addSubview(imageView)
    }
    
    func addShadow() {
        let shadowPath = UIBezierPath(cgPath: circleLayer.path!)
        circleLayer.masksToBounds = false;
        circleLayer.shadowColor = UIColor.black.cgColor
        circleLayer.shadowOffset = NumberpadKeyConstants.offset
        circleLayer.shadowOpacity = Float(NumberpadKeyConstants.opacity)
        circleLayer.shadowPath = shadowPath.cgPath
    }
    
    func addOutline() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 50,y: 50), radius: 50, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = Constants.BACKGROUND_COLOR.cgColor
        circleLayer.strokeColor = Constants.THEME_COLOR.cgColor
        circleLayer.lineWidth = 3.0
        
        self.layer.addSublayer(circleLayer)
    }
    
    func drawCircleContainer() {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: circleLayer.frame.width / 2,y: circleLayer.frame.height / 2),
            radius: (circleLayer.frame.height / 2) - CGFloat(YPADDING),
            startAngle: 0, endAngle: CGFloat(M_PI * 2),
            clockwise: true)
        circleLayer.path = circlePath.cgPath
    }

}
