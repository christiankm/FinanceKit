//
//  ChangeTests.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 04/09/2019.
//  Copyright © 2019 Christian Mitteldorf. All rights reserved.
//

import XCTest
@testable import FinanceKit

class ChangeTests: XCTestCase {

    static var allTests = [
        ("testInit", testInit)
    ]

    func testInit() {
        let change = Change(value: 0.34)
        XCTAssertEqual(change.value, 0.34)
        XCTAssertTrue(change.isPositive)
    }
}
