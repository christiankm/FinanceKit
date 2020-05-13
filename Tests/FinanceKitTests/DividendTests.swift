//
//  DividendTests.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 05/13/20.
//

import XCTest
@testable import FinanceKit

class DividendTests: XCTestCase {

    func testInitWithSymbol() {
        let date = Date()
        let sut = Dividend(symbol: .aapl, payDate: date)

        XCTAssertEqual(sut.symbol, .aapl)
        XCTAssertEqual(sut.payDate, date)
        XCTAssertEqual(sut.value, 0)
    }

    func testInitWithSymbolAndValue() {
        let date = Date()
        let sut = Dividend(symbol: .aapl, payDate: date, value: Money(1.43))

        XCTAssertEqual(sut.symbol, .aapl)
        XCTAssertEqual(sut.payDate, date)
        XCTAssertEqual(sut.value, 1.43)
    }
}
