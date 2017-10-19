//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}


protocol CustomStringConvertible {
    var description : String {get}
}

protocol Mathematics {
    func add(_ : Money) -> Money
    func subtract (_ : Money) -> Money
}

extension Double {
    var USD: Money {
        return Money(amount: Int(self), currency: "USD")
    }
    var EUR: Money {
        return Money(amount: Int(self), currency: "EUR")
    }
    var GBP: Money {
        return Money(amount: Int(self), currency: "GBP")
    }
    var CAN: Money {
        return Money(amount: Int(self), currency: "CAN")
    }
}

////////////////////////////////////
// Money
//
public struct Money: CustomStringConvertible, Mathematics {
    public var amount : Int
    public var currency : String

    var description : String {
        get {
            return currency + String(amount)
        }
    }
    
    public func convert(_ to: String) -> Money {
        var mon = Double(self.amount)
        switch self.currency {
        case "GBP":
            mon *= 2
        case "EUR":
            mon /= 1.5
        case "CAN":
            mon /= 1.25
        default:
            mon /= 1.0
        }
        if to == "GBP" {
            mon /= 2
        } else if to == "CAN" {
            mon *= 1.25
        } else if to == "EUR" {
            mon *= 1.5
        }
        return Money(amount : Int(mon), currency: to)
    }
    
    public func add(_ to: Money) -> Money {
        if(self.currency == to.currency){
            return Money(amount: self.amount + to.amount, currency: to.currency)
        }else{
            return Money(amount: self.convert(to.currency).amount + to.amount, currency: to.currency)
        }
    }
    
    public func subtract(_ other: Money) -> Money {
        if(self.currency == other.currency){
            return Money(amount: self.amount - other.amount, currency: self.currency)
        }else{
            let curr = self.convert(other.currency)
            return Money(amount: curr.amount - other.amount, currency: other.currency)
        }
    }
}

////////////////////////////////////
// Job
//
open class Job: CustomStringConvertible {
    fileprivate var title : String
    fileprivate var type : JobType

    public enum JobType {
    case Hourly(Double)
    case Salary(Int)
    }

    public var description: String {
        get {
            let desc = "The job is \(title) and it is paid $"
            switch type {
            case .Hourly(let pay):
                return desc + "\(pay) per hour"
            case .Salary(let pay):
                return desc + "\(pay) per year"
            }
        }
    }
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }

    open func calculateIncome(_ hours: Int) -> Int {
        switch type {
        case .Hourly(let pay):
            return Int(pay * Double(hours))
        case .Salary(let pay):
            return pay
        }
    }

    open func raise(_ amt : Double) {
        switch self.type {
        case .Hourly(let pay):
            self.type = JobType.Hourly(pay + amt)
        case .Salary(let pay):
            self.type = JobType.Salary(Int(amt) + pay)
        }
    }
}

////////////////////////////////////
// Person
//
open class Person: CustomStringConvertible {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0

    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job
        }
        set(value) {
            if (age >= 16) {
                self._job = value
            }
        }
    }

    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if (self.age >= 18) {
                self._spouse = value
            }
        }
    }
    var description : String {
        get {
            return "This person's name is \(firstName) \(lastName) and they are \(age)."
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }

    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
}

////////////////////////////////////
// Family
//
open class Family : CustomStringConvertible {
    fileprivate var members : [Person] = []

    public init(spouse1: Person, spouse2: Person) {
        members.append(spouse1)
        members.append(spouse2)
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
        }
    }
    
    var description : String {
        get {
            var result = "Family members: "
            for person in members {
                result += "\(person.firstName) \(person.lastName), "
            }
            return result
        }
    }

    open func haveChild(_ child: Person) -> Bool {
        for person in members {
            if person.age >= 21 {
                members.append(child)
                return true
            }
        }
        return false
    }

    open func householdIncome() -> Int {
        var total = 0
        for person in members {
            if (person.job != nil) {
                total += person.job!.calculateIncome(50*40)
            }
        }
        return total
    }
}





