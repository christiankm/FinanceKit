//
//  CurrencyFormatterTests.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 07/05/2020.
//

import XCTest
import FinanceKit

class CurrencyFormatterTests: XCTestCase {

    func testDecimalFromString() {
        let sut = CurrencyFormatter(currency: .usDollars)
        let decimal = sut.decimal(from: "$1,234.99")!
        XCTAssertEqual(decimal, Decimal(1234.99))
    }

    func testMoneyFromString() {
        let sut = CurrencyFormatter(currency: .usDollars)
        let money = sut.money(from: "$1,234.99")!
        XCTAssertEqual(money.amount, Decimal(1234.99))
        XCTAssertEqual(money.currency, .usDollars)
    }

    func testStringFromDecimal() {
        let sut = CurrencyFormatter(currency: .usDollars)
        let string = sut.string(from: Decimal(1234.99))!
        XCTAssertEqual(string, "$1,234.99")
    }

    func testStringFromMoney() {
        let sut = CurrencyFormatter(currency: .usDollars)
        let string = sut.string(from: Money(1234.99))!
        XCTAssertEqual(string, "$1,234.99")
    }
}
