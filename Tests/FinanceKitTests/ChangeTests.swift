//
//  ChangeTests.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 04/09/2019.
//  Copyright © 2019 Christian Mitteldorf. All rights reserved.
//

import XCTest
@testable import FinanceKit

class ChangeTests: XCTestCase {

    static var allTests = [
        ("testInit", testInit)
    ]

    func testInit() {
        let change = Change(value: 0.34)
        XCTAssertEqual(change.value, 0.34)
    }

    func testZeroChange() {
        XCTAssertEqual(Change.zero.value, 0)
    }

    func testEquatable() {
        XCTAssertEqual(Change.zero, Change.zero)
    }

    func testIsPositive() {
        XCTAssertTrue(Change(value: 1).isPositive)
        XCTAssertTrue(Change(value: 0).isPositive)
        XCTAssertFalse(Change(value: -1).isPositive)
    }

    func testIsNegative() {
        XCTAssertTrue(Change(value: -1).isNegative)
        XCTAssertFalse(Change(value: 0).isNegative)
        XCTAssertFalse(Change(value: 1).isNegative)
    }

    func testPercentageText() {
        XCTAssertEqual(Change(value: 0.34).percentageText, "0.34 %")
    }
}
