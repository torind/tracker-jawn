//
//  TagInputView.swift
//  Tracker Jawn
//
//  Created by Torin on 5/30/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class TagInputView: UIView, UITextFieldDelegate {
    let outline = CAShapeLayer()
    let label = UILabel()
    let LABEL_PADDING : CGFloat = 5.0
    var inputChars : String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        addSubview(categoryLabel)
        addSubview(textField)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tf_hPad = CGFloat(40.0)
        categoryLabel.frame = CGRect(x: 0.0,
                                     y: 0.0,
                                     width: frame.width,
                                     height: categoryLabel.text!.height(withConstrainedWidth: frame.width, font: categoryLabel.font))
        textField.frame = CGRect(x: tf_hPad, y: categoryLabel.frame.maxY,
                                 width: frame.width - 2 * tf_hPad, height: 24.0)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    lazy var categoryLabel : UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeue", size: 18)
        view.textAlignment = .center
        let text = "Category:"
        view.text = text
        return view
    }()
    
    lazy var textField : UITextField = {
        let view = UITextField()
        view.textAlignment = .center
        view.delegate = self
        return view
    }()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }

}
