//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class PriceTargetTests: XCTestCase {

    func testInit() throws {
        let date = Date()
        let sut = PriceTarget(price: 23.22, on: date)

        XCTAssertEqual(sut.price, 23.22)
        XCTAssertEqual(sut.date, date)
    }
}
