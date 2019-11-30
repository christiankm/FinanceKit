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
        ("testInitWithPositiveChange", testInitWithPositiveChange),
        ("testInitWithNegativeChange", testInitWithNegativeChange),
        ("testZeroChange", testZeroChange),
        ("textEquatable", testEquatable),
        ("testIsPositive", testIsPositive),
        ("testIsNegative", testIsNegative),
        ("testPercentageText", testPercentageText)
    ]

    func testInitWithPositiveChange() {
        let cost = Decimal(10)
        let factor = Decimal(1.2)

        let change = Change(cost: cost, currentValue: cost * factor)
        let expectedAmountValue = Decimal(2)
        let expectedPercentageValue = 20.0

        XCTAssertEqual(change.amountValue, expectedAmountValue)
        XCTAssertEqual(change.percentageValue, expectedPercentageValue, accuracy: 0.00001)
    }

    func testInitWithNegativeChange() {
        let cost = Decimal(10)
        let factor = Decimal(0.6)

        let change = Change(cost: cost, currentValue: cost * factor)
        let expectedAmountValue = Decimal(-4)
        let expectedPercentageValue = -40.0

        XCTAssertEqual(change.amountValue, expectedAmountValue)
        XCTAssertEqual(change.percentageValue, expectedPercentageValue, accuracy: 0.00001)
    }

    func testInitWithPercentageValue() {
        let value = Double.random(in: -1...1)
        let change = Change(percentageValue: value)
        let expectedAmountValue = Decimal(value < 0 ? -1 : 1)
        XCTAssertEqual(change.amountValue, expectedAmountValue)
        XCTAssertEqual(change.percentageValue, value)
    }

    func testZeroChange() {
        XCTAssertEqual(Change.zero.amountValue, 0)
        XCTAssertEqual(Change.zero.percentageValue, 0)
    }

    func testEquatable() {
        XCTAssertEqual(Change.zero, Change.zero)
    }

    func testIsPositive() {
        XCTAssertTrue(Change(cost: 0, currentValue: 1).isPositive)
        XCTAssertTrue(Change.zero.isPositive)
        XCTAssertFalse(Change(cost: 0, currentValue: -1).isPositive)
    }

    func testIsNegative() {
        XCTAssertTrue(Change(cost: 0, currentValue: -1).isNegative)
        XCTAssertFalse(Change.zero.isNegative)
        XCTAssertFalse(Change(cost: 0, currentValue: 1).isNegative)
    }

    func testPercentageText() {
        let cost = Decimal(1.23)
        let change = Change(cost: cost, currentValue: cost * 3)
        XCTAssertEqual(change.percentageText, "200.0 %")
    }
}
