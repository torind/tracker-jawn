//
//  BalanceHistoryModel.swift
//  Tracker Jawn
//
//  Created by Torin on 5/16/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import Foundation

class BalanceHistory {
    var todayAmount = 0.0
    
    init() {
        
    }
    
    func getTodayAmount() -> Double {
        return todayAmount
    }
}
