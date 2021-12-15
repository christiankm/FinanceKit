//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

@testable import FinanceKit
import XCTest

class StockTests: XCTestCase {

    func testEquatable() {
        let apple = Stock(symbol: .aapl, company: .apple, price: 123, currency: .usDollars)
        let apple2 = apple
        let cake = Stock(symbol: .cake, company: .cake, price: 123, currency: .usDollars)

        XCTAssertTrue(apple == apple2)
        XCTAssertFalse(apple == cake)
    }
}
