//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class SplitTests: XCTestCase {

    private let date = Date()

    func testInitWithDateRatio() throws {
        let sut = Split(date: date, ratio: 0.25)

        XCTAssertEqual(sut.date, date)
        XCTAssertEqual(sut.ratio, 0.25)
    }

    func testInitWithDateFactor() throws {
        let sut = Split(date: date, fromFactor: 1, toFactor: 5)

        XCTAssertEqual(sut.date, date)
        XCTAssertEqual(sut.ratio, 0.20)
    }

    func testInitWithDateZeroToFactor() throws {
        let sut = Split(date: date, fromFactor: 1, toFactor: 0)

        XCTAssertEqual(sut.date, date)
        XCTAssertEqual(sut.ratio, 0.00)
    }

    func testInitWithDateReverseFactor() throws {
        let sut = Split(date: date, fromFactor: 3, toFactor: 1)

        XCTAssertEqual(sut.date, date)
        XCTAssertEqual(sut.ratio, 3.00)
    }

    func testIsReverseSplit() throws {
        let split = Split(date: date, fromFactor: 1, toFactor: 5)
        XCTAssertFalse(split.isReverseSplit)

        let reverseSplit = Split(date: date, fromFactor: 3, toFactor: 1)
        XCTAssertTrue(reverseSplit.isReverseSplit)
    }
}
