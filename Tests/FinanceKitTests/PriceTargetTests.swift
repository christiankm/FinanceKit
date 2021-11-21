//
//  PriceTargetTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 23/04/2020.
//

import FinanceKit
import XCTest

class PriceTargetTests: XCTestCase {

    func testInit() throws {
        let date = Date()
        let sut = PriceTarget(price: 23.22, on: date)

        XCTAssertEqual(sut.price, 23.22)
        XCTAssertEqual(sut.date, date)
    }
}
