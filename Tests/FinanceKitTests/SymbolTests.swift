//
//  SymbolTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 09/11/2019.
//  Copyright © 2019 Mitteldorf. All rights reserved.
//

import XCTest
@testable import FinanceKit

class SymbolTests: XCTestCase {

    func testInitWithValidString() {
        let symbol = Symbol(rawValue: "AAPL")
        XCTAssertNotNil(symbol)
        XCTAssertEqual(symbol?.rawValue, "AAPL")
    }

    func testInitWithEmptyStringReturnsNil() {
        XCTAssertNil(Symbol(rawValue: ""))
    }
}
