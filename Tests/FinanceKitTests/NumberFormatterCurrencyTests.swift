//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import XCTest

class NumberFormatterCurrencyTests: XCTestCase {

    func testStandardStyleFormatter() {
        let sut = NumberFormatter.standard(locale: Locale(identifier: "en_US"))

        XCTAssertEqual(sut.string(from: 2500.32), "2500")
    }

    func testCurrencyStyleFormatter() {
        let sut = NumberFormatter.currency(locale: Locale(identifier: "en_US"))

        XCTAssertEqual(sut.string(from: 2500.32), "$2,500.32")
    }

    func testMonetaryStyleFormatter() {
        let sut = NumberFormatter.monetary(locale: Locale(identifier: "en_US"))

        XCTAssertEqual(sut.string(from: 2500.32), "2,500.32")
    }
}
