//
//  PercentageTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 13/05/2020.
//

import FinanceKit
import XCTest

class PercentageTests: XCTestCase {

    func testZero() throws {
        let sut = Percentage.zero

        XCTAssertEqual(sut.rawValue, 0)
    }

    func testInitWithRawValue() {
        let sut1 = Percentage(10.0)
        XCTAssertEqual(sut1.rawValue, 10)

        let sut2 = Percentage(rawValue: 22)
        XCTAssertEqual(sut2.rawValue, 22)
    }

    func testFormattedString() {
        let sut = Percentage(0.2)

        XCTAssertEqual(sut.formattedString, "0.20%")
    }

    func testBasisPoints() {
        let sut = Percentage(22.3)

        XCTAssertEqual(sut.basisPoints, 2230)
    }

    func testComparable() {
        let lhs = Percentage(10)
        let rhs = Percentage(30)

        XCTAssertLessThan(lhs, rhs)
    }
}
