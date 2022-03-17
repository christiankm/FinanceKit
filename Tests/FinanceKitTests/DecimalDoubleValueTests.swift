//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class DecimalDoubleValueTests: XCTestCase {

    func testDecimalDoubleValue() {
        let randomValue = Double.random(in: -1000 ... 1000)
        let decimal = Decimal(randomValue)
        XCTAssertEqual(decimal.doubleValue, randomValue, accuracy: 0.0000001)
    }
}
