//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class CurrencyPairTests: XCTestCase {

    func testInit() {
        let pair = CurrencyPair(
            baseCurrency: .usDollars,
            secondaryCurrency: .danishKroner,
            rate: 0.64
        )

        XCTAssertNotEqual(pair.baseCurrency, pair.secondaryCurrency)
        XCTAssertEqual(pair.baseCurrency.code.rawValue, "USD")
        XCTAssertEqual(pair.secondaryCurrency.code.rawValue, "DKK")
        XCTAssertEqual(pair.rate, 0.64)
    }

    func testInitWithSameCurrency() {
        let pair = CurrencyPair(
            baseCurrency: .danishKroner,
            secondaryCurrency: .danishKroner,
            rate: 1.00
        )

        XCTAssertEqual(pair.baseCurrency.code.rawValue, "DKK")
        XCTAssertEqual(pair.secondaryCurrency.code.rawValue, "DKK")
        XCTAssertEqual(pair.rate, 1.00)
    }
}
