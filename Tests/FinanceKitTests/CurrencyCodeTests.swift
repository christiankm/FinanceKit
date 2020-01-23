//
//  CurrencyCodeTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 30/11/2019.
//

import XCTest
import FinanceKit

class CurrencyCodeTests: XCTestCase {

    func testCurrencyCodeString() {
        let currency = CurrencyCode.DKK
        XCTAssertEqual(currency.currencyCodeString, "DKK")
    }
}
