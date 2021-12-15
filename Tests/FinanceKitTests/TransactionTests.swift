//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

@testable import FinanceKit
import XCTest

class TransactionTests: XCTestCase {

    func testInit() {
        let transaction = mockTransaction(type: .buy)

        if case .buy = transaction.type {} else {
            XCTFail("Unexpected Transaction Type")
        }
        XCTAssertNotNil(transaction.symbol)
        XCTAssertEqual(transaction.symbol.rawValue, "AAPL")
        XCTAssertEqual(transaction.price, 180.34)
        XCTAssertEqual(transaction.quantity, 23)
        XCTAssertEqual(transaction.commission, 13)
    }

    func testTransactionCostBuy() {
        let transaction = mockTransaction(type: .buy)
        XCTAssertEqual(transaction.transactionCost, -4160.82)
    }

    func testTransactionCostSell() {
        let transaction = mockTransaction(type: .sell)
        XCTAssertEqual(transaction.transactionCost, 4134.82)
    }

    func testBuyTransactionsAddsCommissionCost() {
        let transaction = mockTransaction(type: .buy)
        XCTAssertEqual(transaction.transactionCost, -4160.82)
    }

    func testSellTransactionsSubtractsCommissionCost() {
        let transaction = mockTransaction(type: .sell)
        XCTAssertEqual(transaction.transactionCost, 4134.82)
    }

    func testTransactionCostDividend() {
        let transaction = mockTransaction(type: .dividend)
        XCTAssertEqual(transaction.transactionCost, 4147.82)
    }

    func testDividendReceived() {
        let transaction = mockTransaction(type: .dividend)
        XCTAssertEqual(transaction.transactionCost, 4147.82)
    }

    private func mockTransaction(type: TransactionType) -> Transaction {
        Transaction(
            type: type,
            symbol: Symbol(rawValue: "AAPL")!, // swiftlint:disable:this force_unwrapping
            date: Date(),
            price: 180.34,
            quantity: 23,
            commission: 13
        )
    }
}
