//
//  StockTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 29/06/2017.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import XCTest
@testable import FinanceKit

class StockTests: XCTestCase {

    func testEquatable() {
        let apple = Stock(symbol: .aapl, company: .apple, price: 123, currency: .usDollars)
        let apple2 = apple
        let cake = Stock(symbol: .cake, company: .cake, price: 123, currency: .usDollars)

        XCTAssertTrue(apple == apple2)
        XCTAssertFalse(apple == cake)
    }
}
