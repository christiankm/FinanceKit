//
//  XCTestManifests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 23/01/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FinanceKitTests.allTests)
    ]
}
#endif
