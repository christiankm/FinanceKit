//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class AssetAllocationTests: XCTestCase {

    func testInit() throws {
        let sut = AssetAllocation(
            name: "Stocks",
            allocation: Percentage(0.3),
            returnRate: Percentage(0.09)
        )

        XCTAssertEqual(sut.name, "Stocks")
        XCTAssertEqual(sut.allocation.decimal, 0.3)
        XCTAssertEqual(sut.returnRate.decimal, 0.09)
    }

    func testAverageReturnRate() throws {
        let emptyAllocations = [AssetAllocation]()
        XCTAssertEqual(emptyAllocations.averageReturnRate, .zero)

        let oneAllocation = [
            AssetAllocation(
                name: "Stocks",
                allocation: Percentage(0.3),
                returnRate: Percentage(0.09)
            )
        ]
        XCTAssertEqual(oneAllocation.averageReturnRate, Percentage(0.027))

        let multipleAllocations = [
            AssetAllocation(
                name: "Stocks",
                allocation: Percentage(0.7),
                returnRate: Percentage(0.11)
            ),
            AssetAllocation(
                name: "Bonds",
                allocation: Percentage(0.1),
                returnRate: Percentage(0.02)
            ),
            AssetAllocation(
                name: "Cash",
                allocation: Percentage(0.2),
                returnRate: Percentage(-0.03)
            )
        ]
        XCTAssertEqual(multipleAllocations.averageReturnRate, Percentage(0.073))
    }
}
