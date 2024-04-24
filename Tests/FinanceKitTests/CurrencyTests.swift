//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

@testable import FinanceKit
import XCTest

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

    func testSymbol() {
        // TODO: add test case for all symbols
//        XCTAssertEqual(Currency.danishKroner.symbol, "kr.")
        XCTAssertTrue(Currency.danishKroner.symbol == "kr." || Currency.danishKroner.symbol == "DKK")
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

    @available(iOS 16, macOS 13, *)
    func testCommonISOCurrencyCodes() {
        XCTAssertEqual(Currency.commonISOCurrencyCodes, NSLocale.commonISOCurrencyCodes)
    }
}
