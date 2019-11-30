//
//  TransactionTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 08/11/2019.
//

import XCTest
@testable import FinanceKit

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
    }

    func testTransactionCostBuy() {
        let transaction = mockTransaction(type: .buy)
        XCTAssertEqual(transaction.transactionCost, -4147.82)
    }

    func testTransactionCostSell() {
        let transaction = mockTransaction(type: .sell)
        XCTAssertEqual(transaction.transactionCost, 4147.82)
    }

    private func mockTransaction(type: TransactionType) -> Transaction {
        Transaction(
            type: type,
            symbol: Symbol(rawValue: "AAPL")!, //swiftlint:disable:this force_unwrapping
            date: Date(),
            price: 180.34,
            quantity: 23
        )
    }
}
