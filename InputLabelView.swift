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
    
    /**
     Deletes the last inputed characters
     - returns: the new display amount
     */
    func backspace() {
        if (inputChars.characters.count > 0) {
            let index = inputChars.index(inputChars.endIndex, offsetBy: -1)
            inputChars = inputChars.substring(to: index)
        }
        parseInputChars()
    }
    
    /**
     Adds input to the input characters and returns the display amount
     - parameter char: the character that was input
     - returns: the corresponfing delay amount
     */
    func processInput(char : String) {
        inputChars = inputChars + char
        parseInputChars()
    }
    
    /**
     Parses the input characters as a dollar amount a.k.a. a double with two decimals
     - returns: the string to be displayed for the given input
     */
    func parseInputChars() {
        let displayAmount : String
        let inputLength = inputChars.characters.count
        switch(inputLength) {
        case 0 :
            displayAmount = "$ .  "
        case 1 :
            displayAmount = "$ . " + inputChars
        case 2 :
            displayAmount = "$ ." + inputChars
        default :
            let index = inputChars.index(inputChars.endIndex, offsetBy: -2)
            let decimals = inputChars.substring(from: index)
            let dollars = inputChars.substring(to: index)
            displayAmount = "$" + dollars + "." + decimals
        }
        label.text = displayAmount
    }

    func resetInput() {
        inputChars = ""
        parseInputChars()
    }
    
    func getDoubleForInput() -> Double {
        let expenseDouble = Double(inputChars)! / 100
        return expenseDouble
    }

}
