//
//  TestData.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 23/04/2020.
//

import FinanceKit

extension Company {
    static let apple = Company(symbol: .aapl, name: "Apple Inc.", currency: .usDollars)
    static let cake = Company(symbol: .cake, name: "The Cheesecake Factory Inc.", currency: .usDollars)
    static let coke = Company(symbol: .ko, name: "The Coca-Cola Company Inc.", currency: .usDollars)
}

extension Currency {
    static let danishKroner = Currency(code: .dkk)
    static let usDollars = Currency(code: .usd)
}

extension CurrencyCode {
    static let dkk = CurrencyCode(rawValue: "DKK")
    static let usd = CurrencyCode(rawValue: "USD")
}

extension Holding {
    static let apple = Holding(symbol: .aapl, quantity: 16, costBasis: 13, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0)
    static let cake = Holding(symbol: .cake, quantity: 5, costBasis: 44.21, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0)
    static let coke = Holding(symbol: .ko, quantity: 22, costBasis: 12.83, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0)
}

extension Portfolio {

}

extension Stock {
    static let apple = Stock(symbol: .aapl, company: .apple, price: 0, currency: .usDollars)
    static let cake = Stock(symbol: .cake, company: .cake, price: 0, currency: .usDollars)
    static let coke = Stock(symbol: .ko, company: .coke, price: 0, currency: .usDollars)
}

extension Symbol {
    static let aapl = Symbol("AAPL")!
    static let cake = Symbol(rawValue: "CAKE")!
    static let ko = Symbol(rawValue: "KO")!
}
