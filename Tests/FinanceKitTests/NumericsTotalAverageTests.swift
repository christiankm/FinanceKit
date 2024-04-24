//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import XCTest

class NumericsTotalAverageTests: XCTestCase {

    func testTotalForNumericCollection() throws {
        let sut: [Double] = [23, 84.23, -123, 3]
        let total = sut.total

        XCTAssertEqual(total, -12.77, accuracy: 0.01)
    }

    func testAverageForBinaryIntegerCollection() throws {
        let sut: [Int] = [23, 84, 123, 3]
        let average = sut.average

        XCTAssertEqual(average, 58.25, accuracy: 0.01)
    }

    func testAverageForEmptyBinaryIntegerCollection() throws {
        let sut: [Int] = []
        let average = sut.average

        XCTAssertEqual(average, 0, accuracy: 0.01)
    }

    func testAverageForBinaryFloatingPointCollection() throws {
        let sut: [Double] = [23.2, 84.23, 123.87, 3.1]
        let average = sut.average

        XCTAssertEqual(average, 58.6, accuracy: 0.01)
    }

    func testAverageForEmptyBinaryFloatingPointCollection() throws {
        let sut: [Double] = []
        let average = sut.average

        XCTAssertEqual(average, 0, accuracy: 0.01)
    }

    func testAverageForDecimalCollection() throws {
        let sut: [Decimal] = [23, 84.23, -123, 3]
        let average = sut.average

        XCTAssertEqual(average, -3.1925)
    }

    func testAverageForEmptyDecimalCollection() throws {
        let sut: [Decimal] = []
        let average = sut.average

        XCTAssertEqual(average, 0)
    }
}
