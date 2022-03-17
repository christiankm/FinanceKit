//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import Foundation

extension Company {
    static let apple = Company(symbol: .aapl, name: "Apple Inc.", currency: .usDollars)
    static let cake = Company(symbol: .cake, name: "The Cheesecake Factory Inc.", currency: .usDollars)
    static let coke = Company(symbol: .ko, name: "The Coca-Cola Company Inc.", currency: .usDollars)
}

extension Currency {
    static let danishKroner = Currency(code: CurrencyCode.danishKrone)
    static let usDollars = Currency(code: CurrencyCode.unitedStatesDollar)
    static let australianDollars = Currency(code: CurrencyCode.australianDollar)
}

extension Date {
    static let jan1 = Date(day: 01, month: 01, year: 2010)!
    static let jan2 = Date(day: 02, month: 01, year: 2010)!
    static let jan3 = Date(day: 03, month: 01, year: 2010)!
    static let jan4 = Date(day: 04, month: 01, year: 2010)!
    static let jan5 = Date(day: 05, month: 01, year: 2010)!
    static let jan6 = Date(day: 06, month: 01, year: 2010)!
    static let jan7 = Date(day: 07, month: 01, year: 2010)!
    static let jan8 = Date(day: 08, month: 01, year: 2010)!
    static let jan9 = Date(day: 09, month: 01, year: 2010)!
}

extension Holding {
    static let apple = Holding(symbol: .aapl, quantity: 16, costBasis: 13, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0)
    static let cake = Holding(symbol: .cake, quantity: 5, costBasis: 44.21, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0)
    static let coke = Holding(symbol: .ko, quantity: 22, costBasis: 12.83, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0)
}

extension Portfolio {}

extension Stock {
    static let apple = Stock(symbol: .aapl, company: .apple, price: 180, currency: .usDollars)
    static let cake = Stock(symbol: .cake, company: .cake, price: 43, currency: .usDollars)
    static let coke = Stock(symbol: .ko, company: .coke, price: 45, currency: .usDollars)
}

extension Symbol {
    static let aapl = Symbol("AAPL")!
    static let cake = Symbol(rawValue: "CAKE")!
    static let ko = Symbol(rawValue: "KO")!
}
