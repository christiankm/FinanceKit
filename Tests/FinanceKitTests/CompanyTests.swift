//
//  CompanyTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 23/01/2020.
//

import XCTest
import FinanceKit

class CompanyTests: XCTestCase {

    func testInit() {
        let apple = Company(
            symbol: Symbol("AAPL")!, //swiftlint:disable:this force_unwrapping
            name: "Apple Inc.",
            currency: Currency(code: CurrencyCode(rawValue: "USD"))
        )

        XCTAssertEqual(apple.symbol, Symbol("AAPL")!) //swiftlint:disable:this force_unwrapping
        XCTAssertEqual(apple.name, "Apple Inc.")
        XCTAssertEqual(apple.currency, Currency(code: CurrencyCode(rawValue: "USD")))
    }

    func testEquatable() {
        let apple = Company(
            symbol: Symbol("AAPL")!, //swiftlint:disable:this force_unwrapping
            name: "Apple Inc.",
            currency: Currency(code: CurrencyCode(rawValue: "USD"))
        )
        let coke = Company(
            symbol: Symbol("KO")!, //swiftlint:disable:this force_unwrapping
            name: "Coca-Cola",
            currency: Currency(code: CurrencyCode(rawValue: "USD"))
        )

        XCTAssertEqual(apple, apple)
        XCTAssertNotEqual(apple, coke)
    }

    func testComparable() {
        let apple = Company(
            symbol: Symbol("AAPL")!, //swiftlint:disable:this force_unwrapping
            name: "Apple Inc.",
            currency: Currency(code: CurrencyCode(rawValue: "USD"))
        )
        let coke = Company(
            symbol: Symbol("KO")!, //swiftlint:disable:this force_unwrapping
            name: "Coca-Cola",
            currency: Currency(code: CurrencyCode(rawValue: "USD"))
        )

        XCTAssertEqual([coke, apple].sorted(), [apple, coke])
    }
}
