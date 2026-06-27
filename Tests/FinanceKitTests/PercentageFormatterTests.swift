//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class PercentageFormatterTests: XCTestCase {

    func testStringFromPercent() throws {
        let sut = PercentageFormatter()
        let formatted = try sut.string(from: XCTUnwrap(Percentage(percentage: 22.9)))
        XCTAssertEqual(formatted, "22.90%")
    }

    func testStringFromPercentDecimal() throws {
        let sut = PercentageFormatter()
        let formatted = try sut.string(from: XCTUnwrap(Percentage(percentage: 22.9)))
        XCTAssertEqual(formatted, "22.90%")
    }

    func testStringFromPercentWithZeroFractionDigits() throws {
        let sut = PercentageFormatter(maximumFractionDigits: 0)
        let formatted = try sut.string(from: XCTUnwrap(Percentage(decimal: 0.2289)))
        XCTAssertEqual(formatted, "23%")
    }
}
