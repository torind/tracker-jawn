//
//  ProfileStatView.swift
//  Tracker Jawn
//
//  Created by Torin on 5/26/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class ProfileStatView: UIView {
    let H_PADDING = CGFloat(20.0)
    var gradient : CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.BACKGROUND_COLOR
        
        self.backgroundColor = UIColor(hex: 0x34495E)
        
        createGradientOverlay()
        
        addSubview(label)
        addSubview(field)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(_ labelText: String) {
        self.init()
        label.text = labelText
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
        
        let label_h = CGFloat(24.0)
        let label_w = frame.width / 2 - H_PADDING
        let label_y = (frame.height - label_h) / 2
        let label_x = H_PADDING
        
        
        let field_h = CGFloat(28.0)
        let field_w = frame.width / 2 - H_PADDING
        let field_y = (frame.height - field_h) / 2
        let field_x = frame.width / 2
        
    
        field.frame.size = CGSize(width: field_w, height: field_h)
        field.frame.origin = CGPoint(x: field_x, y: field_y)
        
        label.frame.size = CGSize(width: label_w, height: label_h)
        label.frame.origin = CGPoint(x: label_x, y: label_y)
    }
    
    func setField(text : String) {
        field.text = text
    }
    
    lazy var label : UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeue", size: 18.0)!
        view.textAlignment = .left
        view.textColor = UIColor.white
        return view
    }()
    
    lazy var field : UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "EuphemiaUCAS", size: 24.0)!
        view.textAlignment = .right
        view.textColor = UIColor.white
        return view
    }()
    
    func createGradientOverlay() {
        gradient = CAGradientLayer()
        let light = UIColor.black.withAlphaComponent(0.0).cgColor
        let dark = UIColor.black.withAlphaComponent(0.2).cgColor
        gradient.colors = [light, dark]
        self.layer.addSublayer(gradient)
    }
    

}
