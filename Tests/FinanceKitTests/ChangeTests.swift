//
//  ChangeTests.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 04/09/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

@testable import FinanceKit
import XCTest

class ChangeTests: XCTestCase {

    func testInitWithPositiveChange() {
        let cost = Decimal(10)
        let factor = Decimal(1.2)

        let change = Change(cost: cost, currentValue: cost * factor)
        let expectedAmountValue = Decimal(2)
        let expectedPercentageValue = Percentage(percentage: 20.0)

        XCTAssertEqual(change.amount, expectedAmountValue)
        XCTAssertEqual(change.percentage.decimal, expectedPercentageValue.decimal, accuracy: 0.00001)
    }

    func testInitWithNegativeChange() {
        let cost = Decimal(10)
        let factor = Decimal(0.6)

        let change = Change(cost: cost, currentValue: cost * factor)
        let expectedAmountValue = Decimal(-4)
        let expectedPercentageValue = -0.40

        XCTAssertEqual(change.amount, expectedAmountValue)
        XCTAssertEqual(change.percentage.decimal, expectedPercentageValue, accuracy: 0.00001)
    }

    func testInitWithPercentageValue() {
        let value = Percentage(decimal: Double.random(in: -1 ... 1))
        let change = Change(percentageValue: value)
        let expectedAmountValue = Decimal(value < Percentage(0.0) ? -1 : 1)
        XCTAssertEqual(change.amount, expectedAmountValue)
        XCTAssertEqual(change.percentage, value)
    }

    func testInitWithZeroCost() {
        let sut = Change(cost: 0, currentValue: 1)

        XCTAssertEqual(sut.amount, 0)
        XCTAssertEqual(sut.percentage, .zero)
    }

    func testZeroChange() {
        XCTAssertEqual(Change.zero.amount, 0)
        XCTAssertEqual(Change.zero.percentage, Percentage.zero)
    }

    func testEquatable() {
        XCTAssertEqual(Change.zero, Change.zero)
    }

    func testIsPositive() {
        XCTAssertTrue(Change(cost: 100, currentValue: 110).isPositive)
        XCTAssertTrue(Change.zero.isPositive)
        XCTAssertFalse(Change(cost: 100, currentValue: 90).isPositive)
    }

    func testIsNegative() {
        XCTAssertTrue(Change(cost: 100, currentValue: 90).isNegative)
        XCTAssertFalse(Change.zero.isNegative)
        XCTAssertFalse(Change(cost: 100, currentValue: 110).isNegative)
    }

    func testPercentageText() {
        let cost = Decimal(1.23)
        let change = Change(cost: cost, currentValue: cost * 3)
        XCTAssertEqual(change.percentageText, "200.00%")
    }
}
