//
//  XCTestManifests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 23/01/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import XCTest

public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ChangeTests.allTests),
        testCase(CompanyTests.allTests),
        testCase(CurrencyCodeTests.allTests),
        testCase(CurrencyPairTests.allTests),
        testCase(CurrencyTests.allTests),
        testCase(DecimalDoubleValueTests.allTests),
        testCase(HoldingTests.allTests),
        testCase(PortfolioTests.allTests),
        testCase(SymbolTests.allTests),
        testCase(TransactionTests.allTests)
    ]
}
