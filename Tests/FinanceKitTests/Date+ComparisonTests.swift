//
//  Date+ComparisonTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 26/04/2020.
//

import XCTest

class Date_ComparisonTests: XCTestCase {

    func testIsEarlierThan() throws {
        let now = Date()
        let future = Date().addingTimeInterval(5000)

        XCTAssertTrue(now.isEarlierThan(future))
        XCTAssertFalse(now.isEarlierThan(now))
    }

    func testIsLaterThan() throws {
        let now = Date()
        let future = Date().addingTimeInterval(5000)

        XCTAssertFalse(now.isLaterThan(future))
        XCTAssertFalse(now.isLaterThan(now))
    }

    func testIsEarlierThanOrSame() throws {
        let now = Date()
        let future = Date().addingTimeInterval(5000)

        XCTAssertTrue(now.isEarlierThanOrSameAs(future))
        XCTAssertTrue(now.isEarlierThanOrSameAs(now))
    }

    func testIsLaterThanOrSame() throws {
        let now = Date()
        let future = Date().addingTimeInterval(5000)

        XCTAssertFalse(now.isLaterThanOrSameAs(future))
        XCTAssertTrue(now.isLaterThanOrSameAs(now))
    }
}
