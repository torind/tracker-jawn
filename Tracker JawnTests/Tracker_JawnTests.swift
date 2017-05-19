//
//  Tracker_JawnTests.swift
//  Tracker JawnTests
//
//  Created by Torin on 5/14/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import XCTest
import Foundation
import Tracker_Jawn
@testable import Tracker_Jawn

class Tracker_JawnTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func zeroDaysSinceTodayTest() {
        let today = TJDate()
        today.setDate(nsDate: NSDate(), normalize: true)
        let numDays = today.daysSinceToday()
        XCTAssert(numDays == 0)
    }
    
    func oneDaysSinceYesterdayTest() {
        let calendar = NSCalendar.current
        var oneDay = DateComponents()
        oneDay.day = 1
        let tomorrow = calendar.date(byAdding: oneDay, to: NSDate().toDate())!.toNSDate()
        let today = TJDate()
        today.setDate(nsDate: tomorrow, normalize: true)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
