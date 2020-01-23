//
//  CurrencyPairTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 23/01/2020.
//

import XCTest
import FinanceKit

class CurrencyPairTests: XCTestCase {

    func testInit() {
        let pair = CurrencyPair(
            baseCurrency: Currency(code: .USD),
            secondaryCurrency: Currency(code: .DKK),
            rate: 0.64
        )

        XCTAssertNotEqual(pair.baseCurrency, pair.secondaryCurrency)
        XCTAssertNotEqual(pair.rate, 0)
        XCTAssertEqual(pair.baseCurrency, Currency(code: .USD))
        XCTAssertEqual(pair.secondaryCurrency, Currency(code: .DKK))
        XCTAssertEqual(pair.rate, 0.64)
    }
}
