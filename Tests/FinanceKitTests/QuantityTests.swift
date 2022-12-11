//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

final class QuantityTests: XCTestCase {

    func testQuantity() throws {
        XCTAssertEqual(Quantity(140), 140.0)
        XCTAssertEqual(Quantity(10.234), 10.234)
    }
}
