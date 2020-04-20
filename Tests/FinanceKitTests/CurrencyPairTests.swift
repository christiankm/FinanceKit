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
            baseCurrency: Currency(code: "USD"),
            secondaryCurrency: Currency(code: "DKK"),
            rate: 0.64
        )

        XCTAssertNotEqual(pair.baseCurrency, pair.secondaryCurrency)
        XCTAssertEqual(pair.baseCurrency, Currency(code: "USD"))
        XCTAssertEqual(pair.secondaryCurrency, Currency(code: "DKK"))
        XCTAssertEqual(pair.rate, 0.64)
    }

    func testInitWithSameCurrency() {
        let pair = CurrencyPair(
            baseCurrency: Currency(code: "DKK"),
            secondaryCurrency: Currency(code: "DKK"),
            rate: 1.00
        )

        XCTAssertEqual(pair.baseCurrency.code.rawValue, "DKK")
        XCTAssertEqual(pair.secondaryCurrency.code.rawValue, "DKK")
        XCTAssertEqual(pair.rate, 1.00)
    }
}
