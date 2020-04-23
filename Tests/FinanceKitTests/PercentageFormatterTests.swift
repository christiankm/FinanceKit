//
//  PercentageFormatterTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 20/04/2020.
//

import XCTest
import FinanceKit

class PercentageFormatterTests: XCTestCase {

    func testStringFromPercentDouble() throws {
        let sut = PercentageFormatter()
        let formatted = sut.string(from: Percentage(22.9))!
        XCTAssertEqual(formatted, "22.90%")
    }
}
