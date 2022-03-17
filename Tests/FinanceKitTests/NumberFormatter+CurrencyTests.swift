//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import XCTest

class NumberFormatter_CurrencyTests: XCTestCase {

    func testCurrencyStyleFormatter() {
        let sut = NumberFormatter.currency
        sut.locale = Locale(identifier: "en_US")

        XCTAssertEqual(sut.string(from: 2500.32), "$2,500.32")
    }

    func testMonetaryStyleFormatter() {
        let sut = NumberFormatter.monetary
        sut.locale = Locale(identifier: "en_US")

        XCTAssertEqual(sut.string(from: 2500.32), "2,500.32")
    }
}
