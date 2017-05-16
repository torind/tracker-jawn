//
//  InputLabel.swift
//  Tracker Jawn
//
//  Created by Torin on 5/15/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class InputLabelView: UIView {
    let outline = CAShapeLayer()
    let label = UILabel()
    let LABEL_PADDING : CGFloat = 5.0
    var inputChars : String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addBackground() {
        let rect = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 12.0, height: 12.0)).cgPath
        
        outline.path = path
        outline.fillColor = UIColor(colorLiteralRed: 219/255, green: 219/255, blue: 219/255, alpha: 1.0).cgColor
        
        self.layer.addSublayer(outline)
    }
    
    func addLabel() {
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.textAlignment = .center
        label.text = "$ .  "
        self.addSubview(label)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBackground()
        addLabel()
        outline.frame.size = CGSize(width: frame.width, height: frame.height)
        outline.frame.origin = CGPoint(x: 0.0, y: 0.0)
        label.frame.size = CGSize(width: frame.width - 2 * LABEL_PADDING, height: frame.height - 2 * LABEL_PADDING)
        label.frame.origin = CGPoint(x: LABEL_PADDING, y: LABEL_PADDING)
    }
    
    func setText(text : String) {
        label.text = text
    }


}
