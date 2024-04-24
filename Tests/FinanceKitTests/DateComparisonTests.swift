//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import XCTest

class DateComparisonTests: XCTestCase {

    func testIsBefore() throws {
        let now = Date()
        let future = Date().addingTimeInterval(5000)

        XCTAssertTrue(now.isBefore(future))
        XCTAssertFalse(now.isBefore(now))
    }

    func testIsAfter() throws {
        let now = Date()
        let future = Date().addingTimeInterval(5000)

        XCTAssertFalse(now.isAfter(future))
        XCTAssertFalse(now.isAfter(now))
    }

    func testIsBeforeOrSameAs() throws {
        let now = Date()
        let future = Date().addingTimeInterval(5000)

        XCTAssertTrue(now.isBeforeOrSameAs(future))
        XCTAssertTrue(now.isBeforeOrSameAs(now))
    }

    func testIsAfterOrSameAs() throws {
        let now = Date()
        let future = Date().addingTimeInterval(5000)

        XCTAssertFalse(now.isAfterOrSameAs(future))
        XCTAssertTrue(now.isAfterOrSameAs(now))
    }
}
