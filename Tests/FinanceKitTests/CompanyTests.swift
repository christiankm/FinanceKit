//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class CompanyTests: XCTestCase {

    func testInit() {
        let apple = Company(
            symbol: .aapl,
            name: "Apple Inc.",
            currency: .usDollars
        )

        XCTAssertEqual(apple.symbol, .aapl)
        XCTAssertEqual(apple.name, "Apple Inc.")
        XCTAssertEqual(apple.currency.code.rawValue, "USD")
    }

    func testInitWithEmptyName() {
        let apple = Company(
            symbol: .aapl,
            name: "",
            currency: .usDollars
        )

        XCTAssertEqual(apple.symbol, .aapl)
        XCTAssertEqual(apple.name, "AAPL")
        XCTAssertEqual(apple.currency.code.rawValue, "USD")
    }

    func testEquatable() {
        let apple = Company(
            symbol: .aapl,
            name: "Apple Inc.",
            currency: .usDollars
        )
        let coke = Company(
            symbol: .aapl,
            name: "Coca-Cola",
            currency: .usDollars
        )

        XCTAssertEqual(apple, apple)
        XCTAssertNotEqual(apple, coke)
    }

    func testComparable() {
        let apple = Company(
            symbol: .aapl,
            name: "Apple Inc.",
            currency: .usDollars
        )
        let coke = Company(
            symbol: .coke,
            name: "Coca-Cola",
            currency: .usDollars
        )

        XCTAssertEqual([coke, apple].sorted(), [apple, coke])
    }
}
