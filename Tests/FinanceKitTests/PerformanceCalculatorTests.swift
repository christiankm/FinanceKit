//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

@testable import FinanceKit
import XCTest

class PerformanceCalculatorTests: XCTestCase {

    func testTotalChangeFromDate() throws {
        let sut = PerformanceCalculator()
        let change = sut.totalChange(
            from: Date.jan1,
            with: Self.transactions,
            historicalPrices: Self.historicalPrices
        )

        // aapl: 30
        // cake: 80
        // ko: 0
        XCTAssertEqual(change.amount, 110.0)
    }

    func testTotalChangeBetweenDateAndDate() throws {
        let sut = PerformanceCalculator()
        let change = sut.totalChange(
            between: Date.jan1,
            and: Date.jan9,
            with: Self.transactions,
            historicalPrices: Self.historicalPrices
        )

        // aapl: 30
        // cake: 80
        // ko: 0
        XCTAssertEqual(change.amount, 110.0)
    }

    func testHoldingsInPeriod() {
        let sut = PerformanceCalculator()
        let holdings = sut.holdingsInPeriod(with: Self.transactions, from: Date.jan3, to: Date.jan9)
        XCTAssertEqual(holdings.count, 2)
    }

    private static let transactions = [
        Transaction(type: .buy, symbol: .aapl, date: Date.jan1, price: 100, quantity: 10),
        Transaction(type: .buy, symbol: .cake, date: Date.jan3, price: 100, quantity: 10),
        Transaction(type: .buy, symbol: .ko, date: Date.jan5, price: 100, quantity: 10),
        Transaction(type: .buy, symbol: .aapl, date: Date.jan7, price: 100, quantity: 10),
        Transaction(type: .sell, symbol: .ko, date: Date.jan9, price: 100, quantity: 10)
    ]

    private static let historicalPrices: [Symbol: [HistoricalPrice]] = [
        .aapl: [
            HistoricalPrice(date: Date.jan1, price: 130),
            HistoricalPrice(date: Date.jan2, price: 135),
            HistoricalPrice(date: Date.jan3, price: 130),
            HistoricalPrice(date: Date.jan4, price: 120),
            HistoricalPrice(date: Date.jan5, price: 140),
            HistoricalPrice(date: Date.jan6, price: 150),
            HistoricalPrice(date: Date.jan7, price: 145),
            HistoricalPrice(date: Date.jan8, price: 148),
            HistoricalPrice(date: Date.jan9, price: 160)
        ],
        .cake: [
            HistoricalPrice(date: Date.jan1, price: 100),
            HistoricalPrice(date: Date.jan2, price: 105),
            HistoricalPrice(date: Date.jan3, price: 100),
            HistoricalPrice(date: Date.jan4, price: 124),
            HistoricalPrice(date: Date.jan5, price: 130),
            HistoricalPrice(date: Date.jan6, price: 140),
            HistoricalPrice(date: Date.jan7, price: 135),
            HistoricalPrice(date: Date.jan8, price: 148),
            HistoricalPrice(date: Date.jan9, price: 180)
        ],
        .ko: [
            HistoricalPrice(date: Date.jan1, price: 30),
            HistoricalPrice(date: Date.jan2, price: 35),
            HistoricalPrice(date: Date.jan3, price: 30),
            HistoricalPrice(date: Date.jan4, price: 20),
            HistoricalPrice(date: Date.jan5, price: 30),
            HistoricalPrice(date: Date.jan6, price: 50),
            HistoricalPrice(date: Date.jan7, price: 25),
            HistoricalPrice(date: Date.jan8, price: 28),
            HistoricalPrice(date: Date.jan9, price: 22)
        ]
    ]
}
