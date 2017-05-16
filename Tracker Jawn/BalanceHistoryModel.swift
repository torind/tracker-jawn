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
    var inputChars = ""
    
    init() {
        
    }
    
    func getTodayAmount() -> Double {
        return todayAmount
    }
    
    func getDisplayAmount() -> String {
        return parseInputChars()
    }
    
    func backspace() -> String {
        if (inputChars.characters.count > 0) {
            let index = inputChars.index(inputChars.endIndex, offsetBy: -1)
            inputChars = inputChars.substring(to: index)
        }
        print("hurrr")
        print(inputChars)
        return parseInputChars()
    }
    
    func submitInput() -> String {
        //TODO: actually submit the jawn
        inputChars = ""
        return parseInputChars()
    }
    
    func processInput(char : String) -> String {
        inputChars = inputChars + char
        return parseInputChars()
    }
    
    func parseInputChars() -> String {
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
        return displayAmount
    }
}
