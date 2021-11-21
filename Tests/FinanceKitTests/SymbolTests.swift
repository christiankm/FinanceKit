//
//  SymbolTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 09/11/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
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
