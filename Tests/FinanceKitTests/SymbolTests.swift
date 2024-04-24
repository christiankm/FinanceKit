//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

@testable import FinanceKit
import XCTest

class SymbolTests: XCTestCase {

    func testInitWithValidString() {
        let symbol = Symbol(rawValue: "AAPL")
        XCTAssertNotNil(symbol)
        XCTAssertEqual(symbol?.rawValue, "AAPL")
    }

    func testInitWithEmptyStringReturnsNil() {
        XCTAssertNil(Symbol(rawValue: ""))
    }

    func testComparable() {
        let symbol1 = Symbol("AAPL")! // swiftlint:disable:this force_unwrapping
        let symbol2 = Symbol("ABPL")! // swiftlint:disable:this force_unwrapping
        XCTAssertTrue(symbol1 < symbol2)
    }

    func testCustomStringConvertible() {
        let symbol = Symbol("AAPL")
        XCTAssertEqual(symbol?.description, "AAPL")
    }
}
