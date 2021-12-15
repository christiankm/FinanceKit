//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class ExchangeTests: XCTestCase {

    func testInit() throws {
        let sut = Exchange(symbol: "NYSE", name: "New York Stock Exchange")

        XCTAssertEqual(sut.symbol, "NYSE")
        XCTAssertEqual(sut.name, "New York Stock Exchange")
    }
}
