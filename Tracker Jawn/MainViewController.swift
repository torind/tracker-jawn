//
//  MainViewController.swift
//  Tracker Jawn
//
//  Created by Torin on 5/14/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(dailyUsageLabel)
        view.addSubview(dailyUsageCount)
        print("Running")
        view.addSubview(numberpad)
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        imageViewConstraints()
        dailyUsageLabelConstraints()
        dailyUsageCountConstraints()
        numberpadConstraints()
        super.updateViewConstraints()
    }
    
    // ~~~~ SUBVIEWS ~~~~ //
    lazy var imageView: UIImageView! = {
        let view = UIImageView()
        view.image = UIImage(named: "tracker-jawn-logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = UIViewContentMode.scaleAspectFit
        //view.backgroundColor = UIColor.green
        return view
    }()
    
    lazy var dailyUsageLabel : UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Today's Spending:"
        return view
    }()
    
    lazy var dailyUsageCount : UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "$53.14"
        view.font = UIFont.boldSystemFont(ofSize: 24.0)
        view.textAlignment = .center
        return view
    }()
    
    lazy var numberpad : UIView! = {
        let view = NumberKey(label : "1")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // ~~~~ CONSTRAINTS ~~~~ //
    func imageViewConstraints() {
        
        NSLayoutConstraint(
            item: imageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: imageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.9,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: imageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1.0,
            constant: 40.0)
            .isActive = true
    }
    
    func dailyUsageLabelConstraints() {
        NSLayoutConstraint(
            item: dailyUsageLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: dailyUsageLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: imageView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -10.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: dailyUsageLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        
    }
    
    func dailyUsageCountConstraints() {
        NSLayoutConstraint(
            item: dailyUsageCount,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: dailyUsageCount,
            attribute: .top,
            relatedBy: .equal,
            toItem: dailyUsageLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 5.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: dailyUsageCount,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        
    }
    
    func numberpadConstraints() {
        NSLayoutConstraint(
            item: numberpad,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: numberpad,
            attribute: .top,
            relatedBy: .equal,
            toItem: dailyUsageCount,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: numberpad,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 60)
            .isActive = true
        
        NSLayoutConstraint(
            item: numberpad,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 60)
            .isActive = true
        
        
    }


}
