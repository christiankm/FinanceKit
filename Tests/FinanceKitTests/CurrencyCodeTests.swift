//
//  CurrencyCodeTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 30/11/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import XCTest
import FinanceKit

class CurrencyCodeTests: XCTestCase {

    func testCurrencyCodeString() {
        let currency = CurrencyCode(rawValue: "DKK")
        XCTAssertEqual(currency.currencyCodeString, "DKK")
    }
}
