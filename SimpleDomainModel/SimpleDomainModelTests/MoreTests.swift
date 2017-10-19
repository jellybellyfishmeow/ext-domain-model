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
    let fiveGBP = Money(amount: 5, currency: "GBP")
    
    // Tets CustomStringConvertible
    func testMoney() {
        XCTAssert(hundredUSD.description == "USD100")
        XCTAssert(twentyCAN.description == "CAN20")
    }
    
    func testJob() {
        let job = Job(title: "TA", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.description == "The job is TA and it is paid $15.0 per hour")
    }
    
    func testPerson() {
        let jenny = Person(firstName: "Jenny", lastName: "Yang", age: 21)
        XCTAssert(jenny.description == "This person's name is Jenny Yang and they are 21.")
    }
    
    func testFamily() {
        let jenny = Person(firstName: "Jenny", lastName: "Yang", age: 21)
        let joe = Person(firstName: "Joe", lastName: "Meow", age: 22)
        let kid = Person(firstName: "kid", lastName: "kiddo", age: 10)
        let fam = Family(spouse1 : jenny, spouse2 : joe)
        fam.haveChild(_ : kid)
        XCTAssert(fam.description == "Family members: Jenny Yang, Joe Meow, kid kiddo, ")
    }
    
    // Test Mathemativcs
    func testProtocolAddUSDtoUSD() {
        let total = tenUSD.add(tenUSD)
        XCTAssert(total.amount == 20)
        XCTAssert(total.currency == "USD")
    }
    
    func testProtocolAddUSDtoGBP() {
        let total = tenUSD.add(fiveGBP)
        XCTAssert(total.amount == 10)
        XCTAssert(total.currency == "GBP")
    }
    
    func testProtocolSubtractUSDToUSD () {
        let result = hundredUSD.subtract(tenUSD)
        XCTAssert(result.amount == 90 && result.currency == "USD")
    }
    
    func testProtocolSubtractUSDToCAN () {
        let fifteenEUR = Money(amount: 15, currency: "EUR")
        let fiveCAN = Money(amount: 5, currency: "CAN")
        
        let result = fifteenEUR.subtract(fiveCAN)
        XCTAssert(result.amount == 7 && result.currency == "CAN")
    }
    
    // Test currency Extensions
    func testExtension(){
        let mon1 = Money(amount: 20, currency: "USD")
        let mon2 = Money(amount: 50, currency: "GBP")
        let mon3 = Money(amount: 50, currency: "GBP")
        let ext1 = 20.USD
        let ext2 = 50.GBP
        let ext3 = 50.0.GBP

        XCTAssert(mon1.amount == ext1.amount && mon1.currency == ext1.currency)
        XCTAssert(mon2.amount == ext2.amount && mon2.currency == ext2.currency)
        XCTAssert(mon3.amount == ext2.amount && mon3.currency == ext2.currency)

    }

}
