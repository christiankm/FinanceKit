//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class CurrencyFormatterTests: XCTestCase {

    private let usLocale = Locale(identifier: "en_US")

    func testDecimalFromString() throws {
        let sut = CurrencyFormatter(currency: .usDollars, locale: usLocale)
        let decimal = try XCTUnwrap(sut.decimal(from: "$1,234.99"))
        XCTAssertEqual(decimal, Decimal(1234.99))
    }

    func testMoneyFromString() throws {
        let sut = CurrencyFormatter(currency: .usDollars, locale: usLocale)
        let money = try XCTUnwrap(sut.money(from: "$1,234.99"))
        XCTAssertEqual(money.amount, Decimal(1234.99))
        XCTAssertEqual(money.currency, .usDollars)
    }

    func testStringFromDecimalWithNoCurrency() throws {
        let sut = CurrencyFormatter(currency: Currency(code: .none), locale: usLocale)
        let string = try XCTUnwrap(sut.string(from: Decimal(1234.99)))
        XCTAssertEqual(string, "1,234.99")
    }

    func testStringFromDecimal() throws {
        let sut = CurrencyFormatter(currency: .usDollars, locale: usLocale)
        let string = try XCTUnwrap(sut.string(from: Decimal(1234.99)))
        XCTAssertEqual(string, "$1,234.99")
    }

    func testStringFromMoney() throws {
        let sut = CurrencyFormatter(currency: .usDollars, locale: usLocale)
        let string = try XCTUnwrap(sut.string(from: Money(1234.99)))
        XCTAssertEqual(string, "$1,234.99")
    }

    func testStringFromMoneyLocalCurrency() throws {
        let money = Money(123.45, in: .australianDollars)
        let sut = CurrencyFormatter(currency: try XCTUnwrap(money.currency), locale: Locale(identifier: "en_AU"))
        let string = try XCTUnwrap(sut.string(from: money))
        XCTAssertEqual(string, "$123.45")
    }

    func testStringFromMoneyNonLocalCurrency() throws {
        let money = Money(123.45, in: .australianDollars)
        let sut = CurrencyFormatter(currency: try XCTUnwrap(money.currency), locale: usLocale)
        let string = try XCTUnwrap(sut.string(from: money))
        XCTAssertEqual(string, "A$123.45")
    }

    func testStringFromMoneyZeroAmount() throws {
        let sut = CurrencyFormatter(currency: .usDollars, locale: usLocale)
        let string = try XCTUnwrap(sut.string(from: Money(0.0)))
        XCTAssertEqual(string, "$0.00")
    }
}
