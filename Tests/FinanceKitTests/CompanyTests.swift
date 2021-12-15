//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class CompanyTests: XCTestCase {

    func testInit() {
        let apple = Company(
            symbol: Symbol("AAPL")!, // swiftlint:disable:this force_unwrapping
            name: "Apple Inc.",
            currency: .usDollars
        )

        XCTAssertEqual(apple.symbol, Symbol("AAPL")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(apple.name, "Apple Inc.")
        XCTAssertEqual(apple.currency.code.rawValue, "USD")
    }

    func testInitWithEmptyName() {
        let apple = Company(
            symbol: Symbol("AAPL")!, // swiftlint:disable:this force_unwrapping
            name: "",
            currency: .usDollars
        )

        XCTAssertEqual(apple.symbol, Symbol("AAPL")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(apple.name, "AAPL")
        XCTAssertEqual(apple.currency.code.rawValue, "USD")
    }

    func testEquatable() {
        let apple = Company(
            symbol: Symbol("AAPL")!, // swiftlint:disable:this force_unwrapping
            name: "Apple Inc.",
            currency: .usDollars
        )
        let coke = Company(
            symbol: Symbol("KO")!, // swiftlint:disable:this force_unwrapping
            name: "Coca-Cola",
            currency: .usDollars
        )

        XCTAssertEqual(apple, apple)
        XCTAssertNotEqual(apple, coke)
    }

    func testComparable() {
        let apple = Company(
            symbol: Symbol("AAPL")!, // swiftlint:disable:this force_unwrapping
            name: "Apple Inc.",
            currency: .usDollars
        )
        let coke = Company(
            symbol: Symbol("KO")!, // swiftlint:disable:this force_unwrapping
            name: "Coca-Cola",
            currency: .usDollars
        )

        XCTAssertEqual([coke, apple].sorted(), [apple, coke])
    }
}
