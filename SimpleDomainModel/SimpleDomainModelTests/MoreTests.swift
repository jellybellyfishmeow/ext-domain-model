//
//  MoreTests.swift
//  SimpleDomainModelTests
//
//  Created by iGuest on 10/19/17.
//  Copyright © 2017 Ted Neward. All rights reserved.
//

import XCTest
import SimpleDomainModel

class MoreTests: XCTestCase {
    
    let hundredUSD = Money(amount: 100, currency: "USD")
    let tenUSD = Money(amount: 10, currency: "USD")
    let twentyCAN = Money(amount: 20, currency: "CAN")
    
    func testMoney() {
        XCTAssert(hundredUSD.description == "USD100")
        XCTAssert(fifteenCAN.description == "CAN20")
    }
    
    func testJob() {
        let job = Job(title: "TA", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.description == "The job title is TA paid 15.0 per hour")
    }
    
    func testPerson() {
        let kelley = Person(firstName: "Kelley", lastName: "Chen", age: 20)
        XCTAssert(kelley.description == "Kelley, Chen age: 20")
    }
    
    fun testFamily() {
        let kelley = Person(firstName: "Kelley", lastName: "Chen", age: 20)
        XCTAssert(kelley.description == "Kelley, Chen age: 20")
    }
    
    func testAddUSDtoUSD() {
        let total = tenUSD.add(tenUSD)
        XCTAssert(total.amount == 20)
        XCTAssert(total.currency == "USD")
    }
    
    func testAddUSDtoGBP() {
        let total = tenUSD.add(fiveGBP)
        XCTAssert(total.amount == 10)
        XCTAssert(total.currency == "GBP")
    }
    
    func testSubtractUSDToUSD () {
        let result = hundredUSD.subtract(tenUSD)
        XCTAssert(result.amount == 90 && result.currency == "USD")
    }
    
    func testSubtractUSDToCAN () {
        let fifteenEUR = Money(amount: 15, currency: "EUR")
        
        let result = fifteenEUR.subtract(fiveCAN)
        print(result)
        XCTAssert(result.amount == 7 && result.currency == "CAN")
    }
    
}
