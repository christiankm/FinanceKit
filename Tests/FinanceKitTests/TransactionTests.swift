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
        let transaction = Transaction(
            type: .buy,
            symbol: Symbol(rawValue: "AAPL"),
            date: Date(),
            price: Price(rawValue: 180.34),
            quantity: Quantity(rawValue: 23)
        )

        if case .buy = transaction.type {} else {
            XCTFail("Unexpected Transaction Type")
        }
        XCTAssertNotNil(transaction.symbol)
        XCTAssertEqual(transaction.symbol?.rawValue ?? "", "AAPL")
        XCTAssertEqual(transaction.price.rawValue, 180.34)
        XCTAssertEqual(transaction.quantity.rawValue, 23)
    }

    func testTransactionCostBuy() {
        let transaction = Transaction(
            type: .buy,
            symbol: Symbol(rawValue: "AAPL"),
            date: Date(),
            price: Price(rawValue: 180.34),
            quantity: Quantity(rawValue: 23)
        )
        XCTAssertEqual(transaction.transactionCost.rawValue, -4147.82)
    }

    func testTransactionCostSell() {
        let transaction = Transaction(
            type: .sell,
            symbol: Symbol(rawValue: "AAPL"),
            date: Date(),
            price: Price(rawValue: 180.34),
            quantity: Quantity(rawValue: 23)
        )
        XCTAssertEqual(transaction.transactionCost.rawValue, 4147.82)
    }
}
