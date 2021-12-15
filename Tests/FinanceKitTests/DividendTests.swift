//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

@testable import FinanceKit
import XCTest

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
