//
//  NumberFormatter+CurrencyTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 08/05/2020.
//

import XCTest

class NumberFormatter_CurrencyTests: XCTestCase {

    func testCurrencyStyleFormatter() {
        let sut = NumberFormatter.currency
        sut.locale = Locale(identifier: "en_US")

        XCTAssertEqual(sut.string(from: 2500.32), "$2,500.32")
    }

    func testMonetaryStyleFormatter() {
        let sut = NumberFormatter.monetary
        sut.locale = Locale(identifier: "en_US")

        XCTAssertEqual(sut.string(from: 2500.32), "2,500.32")
    }
}
