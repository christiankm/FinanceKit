//
//  StockTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 29/06/2017.
//  Copyright © 2017 Christian Mitteldorf. All rights reserved.
//

import XCTest
@testable import FinanceKit

class StockTests: XCTestCase {

    func testEquatable() {
        let appleSymbol = Symbol("AAPL")!
        let cakeSymbol = Symbol("CAKE")!
        let usd = Currency(code: .USD)
        let apple = Stock(symbol: appleSymbol, company: Company(symbol: appleSymbol, name: "Apple Inc.", currency: usd), price: 123, currency: usd)
        let apple2 = apple
        let cake = Stock(symbol: cakeSymbol, company: Company(symbol: cakeSymbol, name: "Cheesecake", currency: usd), price: 123, currency: usd)

        XCTAssertTrue(apple == apple2)
        XCTAssertFalse(apple == cake)
    }
}
