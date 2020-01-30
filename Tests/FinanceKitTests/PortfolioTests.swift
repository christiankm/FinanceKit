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
        let portfolio = Portfolio(name: "Test Portfolio", currency: Currency(code: .DKK), stocks: [])
        XCTAssertEqual(portfolio.name, "Test Portfolio")
        XCTAssertEqual(portfolio.currency, Currency(code: .DKK))
        XCTAssertEqual(portfolio.stocks.count, 0)
    }
}
