//
//  PortfolioTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 23/01/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import XCTest
import FinanceKit

class PortfolioTests: XCTestCase {

    func testInit() {
        let portfolio = Portfolio(name: "Test Portfolio", currency: Currency(code: CurrencyCode(rawValue: "DKK")), holdings: [])
        XCTAssertEqual(portfolio.name, "Test Portfolio")
        XCTAssertEqual(portfolio.currency, Currency(code: CurrencyCode(rawValue: "DKK")))
        XCTAssertEqual(portfolio.holdings.count, 0)
    }
}
