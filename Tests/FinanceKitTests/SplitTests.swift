//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class SplitTests: XCTestCase {

    private let date = Date()

    func testInitWithDateRatio() throws {
        let sut = Split(symbol: .aapl, date: date, ratio: 0.25)

        XCTAssertEqual(sut.date, date)
        XCTAssertEqual(sut.ratio, 0.25)
    }

    func testInitWithDateFactor() throws {
        let sut = Split(symbol: .aapl, date: date, fromFactor: 1, toFactor: 5)

        XCTAssertEqual(sut.date, date)
        XCTAssertEqual(sut.ratio, 0.20)
    }

    func testInitWithDateZeroToFactor() throws {
        let sut = Split(symbol: .aapl, date: date, fromFactor: 1, toFactor: 0)

        XCTAssertEqual(sut.date, date)
        XCTAssertEqual(sut.ratio, 0.00)
    }

    func testInitWithDateReverseFactor() throws {
        let sut = Split(symbol: .aapl, date: date, fromFactor: 3, toFactor: 1)

        XCTAssertEqual(sut.date, date)
        XCTAssertEqual(sut.ratio, 3.00)
    }

    func testIsReverseSplit() throws {
        let split = Split(symbol: .aapl, date: date, fromFactor: 1, toFactor: 5)
        XCTAssertFalse(split.isReverseSplit)

        let reverseSplit = Split(symbol: .aapl, date: date, fromFactor: 3, toFactor: 1)
        XCTAssertTrue(reverseSplit.isReverseSplit)
    }

    func testComparable() throws {
        let splits: [Split] = [
            Split(symbol: .aapl, date: Date(timeIntervalSinceReferenceDate: 5000), ratio: 0.0),
            Split(symbol: .aapl, date: Date(timeIntervalSinceReferenceDate: 30000), ratio: 0.0),
            Split(symbol: .aapl, date: Date(timeIntervalSinceReferenceDate: 10000), ratio: 0.0),
            Split(symbol: .aapl, date: Date(timeIntervalSinceReferenceDate: 2000), ratio: 0.0),
            Split(symbol: .aapl, date: Date(timeIntervalSinceReferenceDate: 3600), ratio: 0.0),
            Split(symbol: .aapl, date: Date(timeIntervalSinceReferenceDate: 6400), ratio: 0.0)
        ]

        let sut = splits.sorted()
        XCTAssertEqual(sut[0].date.timeIntervalSinceReferenceDate, 30000)
        XCTAssertEqual(sut[1].date.timeIntervalSinceReferenceDate, 10000)
        XCTAssertEqual(sut[2].date.timeIntervalSinceReferenceDate, 6400)
        XCTAssertEqual(sut[3].date.timeIntervalSinceReferenceDate, 5000)
        XCTAssertEqual(sut[4].date.timeIntervalSinceReferenceDate, 3600)
        XCTAssertEqual(sut[5].date.timeIntervalSinceReferenceDate, 2000)
    }
}
