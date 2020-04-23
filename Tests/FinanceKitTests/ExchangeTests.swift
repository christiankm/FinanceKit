//
//  ExchangeTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 23/04/2020.
//

import XCTest
import FinanceKit

class ExchangeTests: XCTestCase {

    func testInit() throws {
        let sut = Exchange(symbol: "NYSE", name: "New York Stock Exchange")

        XCTAssertEqual(sut.symbol, "NYSE")
        XCTAssertEqual(sut.name, "New York Stock Exchange")
    }
}
