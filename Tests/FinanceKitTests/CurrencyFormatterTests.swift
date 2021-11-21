//
//  CurrencyFormatterTests.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 07/05/2020.
//

import FinanceKit
import XCTest

class CurrencyFormatterTests: XCTestCase {

    func testDecimalFromString() {
        let sut = CurrencyFormatter(currency: .usDollars, locale: Locale(identifier: "en_US"))
        let decimal = sut.decimal(from: "$1,234.99")!
        XCTAssertEqual(decimal, Decimal(1234.99))
    }

    func testMoneyFromString() {
        let sut = CurrencyFormatter(currency: .usDollars, locale: Locale(identifier: "en_US"))
        let money = sut.money(from: "$1,234.99")!
        XCTAssertEqual(money.amount, Decimal(1234.99))
        XCTAssertEqual(money.currency, .usDollars)
    }

    func testStringFromDecimalWithNoCurrency() {
        let sut = CurrencyFormatter(currency: Currency(code: .none), locale: Locale(identifier: "en_US"))
        let string = sut.string(from: Decimal(1234.99))!
        XCTAssertEqual(string, "1,234.99")
    }

    func testStringFromDecimal() {
        let sut = CurrencyFormatter(currency: .usDollars, locale: Locale(identifier: "en_US"))
        let string = sut.string(from: Decimal(1234.99))!
        XCTAssertEqual(string, "$1,234.99")
    }

    func testStringFromMoney() {
        let sut = CurrencyFormatter(currency: .usDollars, locale: Locale(identifier: "en_US"))
        let string = sut.string(from: Money(1234.99))!
        XCTAssertEqual(string, "$1,234.99")
    }

    func testStringFromMoneyLocalCurrency() {
        let money = Money(123.45, in: .australianDollars)
        let sut = CurrencyFormatter(currency: money.currency!, locale: Locale(identifier: "en_AU"))
        let string = sut.string(from: money)!
        XCTAssertEqual(string, "$123.45")
    }

    func testStringFromMoneyNonLocalCurrency() {
        let money = Money(123.45, in: .australianDollars)
        let sut = CurrencyFormatter(currency: money.currency!, locale: Locale(identifier: "en_US"))
        let string = sut.string(from: money)!
        XCTAssertEqual(string, "A$123.45")
    }

    func testStringFromMoneyZeroAmount() {
        let sut = CurrencyFormatter(currency: .usDollars, locale: Locale(identifier: "en_US"))
        let string = sut.string(from: Money(0.0))!
        XCTAssertEqual(string, "$0.00")
    }
}
