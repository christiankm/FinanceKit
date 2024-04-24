//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class PercentageTests: XCTestCase {

    func testZero() throws {
        let sut = Percentage.zero

        XCTAssertEqual(sut.decimal, 0)
    }

    func testInitWithDecimal() {
        let sut1 = Percentage(decimal: 0.1)
        XCTAssertEqual(sut1.decimal, 0.1)
        XCTAssertEqual(sut1.basisPoints, 100)

        let sut2 = Percentage(decimal: -1.22)
        XCTAssertEqual(sut2.decimal, -1.22)
        XCTAssertEqual(sut2.basisPoints, -1220)
    }

    func testInitWithPercentage() {
        let sut1 = Percentage(percentage: 10.0)
        XCTAssertEqual(sut1.decimal, 0.1)

        let sut2 = Percentage(percentage: 22.0)
        XCTAssertEqual(sut2.decimal, 0.22)
    }

    func testFormattedString() {
        let sut = Percentage(0.2)
        XCTAssertEqual(sut.formattedString, "20.00%")
    }

    func testBasisPoints() {
        let sut = Percentage(decimal: 0.223)
        XCTAssertEqual(sut.basisPoints, 223)
    }

    func testComparable() {
        let lhs = Percentage(decimal: 0.10)
        let rhs = Percentage(decimal: 0.30)
        XCTAssertLessThan(lhs, rhs)
    }
}
