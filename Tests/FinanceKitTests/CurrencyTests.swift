//
//  CurrencyTests.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 29/11/2019.
//  Copyright © 2019 Mitteldorf. All rights reserved.
//

import XCTest
@testable import FinanceKit

class CurrencyTests: XCTestCase {

    func testInitWithCurrencyCode() {
        let currency = Currency(code: .DKK)
        XCTAssertNotNil(currency)
        XCTAssertEqual(currency.code.rawValue, "DKK")
    }

    func testName() {
        let currency = Currency(code: .DKK)
        XCTAssertEqual(currency.name, "Danish Krone")
    }

    func testLocaleCurrencyCode() {
        XCTAssertEqual(Currency.currencyCode, NSLocale.current.currencyCode)
    }

    func testLocaleCurrencySymbol() {
        XCTAssertEqual(Currency.currencySymbol, NSLocale.current.currencySymbol)
    }

    func testLocalizedStringForCurrencyCode() {
        let string = Currency.localizedString(forCurrencyCode: "DKK")
        XCTAssertEqual(string, "Danish Krone")
    }

    func testISOCurrencyCodes() {
        XCTAssertEqual(Currency.isoCurrencyCodes, NSLocale.isoCurrencyCodes)
    }

    func testCommonISOCurrencyCodes() {
        XCTAssertEqual(Currency.commonIsoCurrencyCodes, NSLocale.commonISOCurrencyCodes)
    }
}
