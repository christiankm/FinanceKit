//
//  CurrencyTests.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 29/11/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import XCTest
@testable import FinanceKit

class CurrencyTests: XCTestCase {

    func testInitWithCurrencyCode() {
        let sut = Currency(code: .danishKrone)

        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.code.rawValue, "DKK")
    }

    func testLocalizedName() {
        let dkkEnglish = Currency(code: .danishKrone, locale: Locale(identifier: "en_US"))
        XCTAssertEqual(dkkEnglish.localizedName, "Danish Krone")
    }

    func testEquatable() {
        let dkk = Currency(code: .danishKrone)
        let usd = Currency(code: .unitedStatesDollar)
        XCTAssertNotEqual(usd, dkk)
    }

    // MARK: - Locale convenience functions

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
