//
//  PercentageFormatterTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 20/04/2020.
//

import FinanceKit
import XCTest

class PercentageFormatterTests: XCTestCase {

    func testStringFromPercent() throws {
        let sut = PercentageFormatter()
        let formatted = sut.string(from: Percentage(percentage: 22.9))!
        XCTAssertEqual(formatted, "22.90%")
    }

    func testStringFromPercentDecimal() throws {
        let sut = PercentageFormatter()
        let formatted = sut.string(from: Percentage(percentage: 22.9))!
        XCTAssertEqual(formatted, "22.90%")
    }

    func testStringFromPercentWithZeroFractionDigits() throws {
        let sut = PercentageFormatter(maximumFractionDigits: 0)
        let formatted = sut.string(from: Percentage(decimal: 0.2289))!
        XCTAssertEqual(formatted, "23%")
    }
}
