//
//  NumberPad.swift
//  Tracker Jawn
//
//  Created by Torin on 5/15/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class NumberPad: UIView {
    var touchDelegate : NumberpadTouchDelegate?
    static let XPADDING = 0.0
    static let YPADDING = 2.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addKeys() {
        let labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", ""]

        let xInterval = frame.width / 3.0
        let yInterval = frame.height / 4.0
        
        for i in 0...11 {
            let row = floor(Double(i / 3))
            let col = i % 3
            let rect = CGRect(x: xInterval * CGFloat(col),
                              y: yInterval * CGFloat(row),
                              width: xInterval,
                              height: yInterval)
            var keyView : UIView
            switch i {
            case 9 :
                keyView = ImageKey(frame: rect, imgName : "numberkey-back")
            case 11 :
                keyView = ImageKey(frame: rect, imgName : "numberkey-done")
            default:
                keyView = NumberKey(frame: rect, label: labels[i])
            }
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(processNumberInput(sender:)))
            keyView.addGestureRecognizer(gestureRecognizer)
            keyView.tag = i
            self.addSubview(keyView)
        }
    }
    
    @IBAction
    func processNumberInput(sender:UITapGestureRecognizer!) {
        if (touchDelegate != nil) {
            touchDelegate!.handleTouch(tag: sender.view!.tag)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addKeys()
    }

}
