//
//  HoldingTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 23/01/2020.
//

import XCTest
import FinanceKit

class HoldingTests: XCTestCase {

    private static let symbol = Symbol("AAPL")! //swiftlint:disable:this force_unwrapping

    func testInitWithDefaultValues() {
        let holding = Holding(symbol: Self.symbol)
        XCTAssertEqual(holding.symbol.rawValue, "AAPL")
        XCTAssertEqual(holding.quantity, 0)
        XCTAssertEqual(holding.costBasis, 0)
        XCTAssertEqual(holding.costBasisInLocalCurrency, 0)
        XCTAssertEqual(holding.currentValue, 0)
        XCTAssertEqual(holding.currentValueInLocalCurrency, 0)
    }

    func testInitWithValues() {
        let holding = Holding(symbol: Self.symbol, quantity: 3,
                              costBasis: 12, costBasisInLocalCurrency: 23,
                              currentValue: 23, currentValueInLocalCurrency: 34)
        XCTAssertEqual(holding.symbol.rawValue, "AAPL")
        XCTAssertEqual(holding.quantity, 3)
        XCTAssertEqual(holding.costBasis, 12)
        XCTAssertEqual(holding.costBasisInLocalCurrency, 23)
        XCTAssertEqual(holding.currentValue, 23)
        XCTAssertEqual(holding.currentValueInLocalCurrency, 34)
    }

    func testAverageCostPerShare() {
        let holding = Holding(symbol: Self.symbol, quantity: 10, costBasis: 16)
        XCTAssertEqual(holding.averageCostPerShare, 1.6)
    }

    func testChange() {
        let holding = Holding(symbol: Self.symbol, quantity: 3,
                              costBasis: 12, costBasisInLocalCurrency: 23,
                              currentValue: 23, currentValueInLocalCurrency: 34)
        let expectedChange = Change(cost: 12, currentValue: 23)
        XCTAssertEqual(holding.change, expectedChange)
    }

    func testChangeInLocalCurrency() {
        let holding = Holding(symbol: Self.symbol, quantity: 3,
                              costBasis: 12, costBasisInLocalCurrency: 23,
                              currentValue: 23, currentValueInLocalCurrency: 34)
        let expectedChange = Change(cost: 23, currentValue: 34)
        XCTAssertEqual(holding.changeInLocalCurrency, expectedChange)
    }

    func testDisplayNameWhenCompanyIsCompanyName() {
        var holding = Holding(symbol: Self.symbol, quantity: 10, costBasis: 16)
        holding.company = Company(symbol: Self.symbol, name: "Apple Inc.", currency: Currency(code: .USD))
        XCTAssertEqual(holding.displayName, "Apple Inc.")
    }

    func testDisplayNameWhenNoCompanyIsSymbol() {
        let holding = Holding(symbol: Self.symbol, quantity: 10, costBasis: 16)
        XCTAssertEqual(holding.displayName, "AAPL")
    }

    // MARK: Test makeHoldings

    func testMakeHoldingsWithNoTransactions() {
        let transactions: [Transaction] = []
        let holdings = Holding.makeHoldings(with: transactions)
        XCTAssertTrue(holdings.isEmpty)
    }

    func testMakeHoldingsWithOnlyBuyTransactions() {
        let aapl = Symbol("AAPL")! //swiftlint:disable:this force_unwrapping
        let cake = Symbol("CAKE")! //swiftlint:disable:this force_unwrapping
        let transactions = [
            Transaction(type: .buy, symbol: aapl, date: Date(), price: 100, quantity: 5, commission: 13),
            Transaction(type: .buy, symbol: aapl, date: Date(), price: 120, quantity: 5, commission: 13),
            Transaction(type: .buy, symbol: cake, date: Date(), price: 60, quantity: 10, commission: 13)
        ]

        let holdings = Holding.makeHoldings(with: transactions)

        let expectedHoldingOfAAPL = Holding(symbol: aapl, quantity: 10,
                                      costBasis: 1126)
        let expectedHoldingOfCAKE = Holding(symbol: cake, quantity: 10,
                                            costBasis: 613)
        XCTAssertEqual(holdings.count, 2)
        XCTAssertEqual(holdings[0].quantity, expectedHoldingOfAAPL.quantity)
        XCTAssertEqual(holdings[0].costBasis, expectedHoldingOfAAPL.costBasis)
        XCTAssertEqual(holdings[1].quantity, expectedHoldingOfCAKE.quantity)
        XCTAssertEqual(holdings[1].costBasis, expectedHoldingOfCAKE.costBasis)
    }

    func testMakeHoldingsWithOnlySellTransactions() {
        let aapl = Symbol("AAPL")! //swiftlint:disable:this force_unwrapping
        let cake = Symbol("CAKE")! //swiftlint:disable:this force_unwrapping
        let transactions = [
            Transaction(type: .sell, symbol: aapl, date: Date(), price: 100, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: aapl, date: Date(), price: 120, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: cake, date: Date(), price: 60, quantity: 10, commission: 13)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        XCTAssertTrue(holdings.isEmpty)
    }

    func testMakeHoldingsWithBuyAndSellTransactions() {
        let aapl = Symbol("AAPL")! //swiftlint:disable:this force_unwrapping
        let cake = Symbol("CAKE")! //swiftlint:disable:this force_unwrapping
        let transactions = [
            Transaction(type: .buy, symbol: aapl, date: Date(), price: 100, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: aapl, date: Date(), price: 120, quantity: 5, commission: 13),
            Transaction(type: .buy, symbol: cake, date: Date(), price: 60, quantity: 10, commission: 13)
        ]

        let holdings = Holding.makeHoldings(with: transactions)

        let expectedHoldingOfCAKE = Holding(symbol: cake, quantity: 10,
                                            costBasis: 613)
        XCTAssertEqual(holdings.count, 1)
        XCTAssertEqual(holdings[0].quantity, expectedHoldingOfCAKE.quantity)
        XCTAssertEqual(holdings[0].costBasis, expectedHoldingOfCAKE.costBasis)
    }

    func testMakeHoldingsWithOnlyDividendTransactions() {
        let aapl = Symbol("AAPL")! //swiftlint:disable:this force_unwrapping
        let cake = Symbol("CAKE")! //swiftlint:disable:this force_unwrapping
        let transactions = [
            Transaction(type: .dividend, symbol: aapl, date: Date(), price: 0.4, quantity: 5),
            Transaction(type: .dividend, symbol: aapl, date: Date(), price: 0.4, quantity: 5),
            Transaction(type: .dividend, symbol: cake, date: Date(), price: 0.6, quantity: 10)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        XCTAssertTrue(holdings.isEmpty)
    }

    func testMakeHoldingsWithBuyAndSellAndDividendTransactions() {
        let aapl = Symbol("AAPL")! //swiftlint:disable:this force_unwrapping
        let transactions = [
            Transaction(type: .buy, symbol: aapl, date: Date(), price: 100, quantity: 5, commission: 13),
            Transaction(type: .buy, symbol: aapl, date: Date(), price: 120, quantity: 5, commission: 13),
            Transaction(type: .dividend, symbol: aapl, date: Date(), price: 0.5, quantity: 10),
            Transaction(type: .sell, symbol: aapl, date: Date(), price: 120, quantity: 3, commission: 13),
            Transaction(type: .dividend, symbol: aapl, date: Date(), price: 0.6, quantity: 7)
        ]

        let holdings = Holding.makeHoldings(with: transactions)

        let expectedHoldingOfAAPL = Holding(symbol: aapl, quantity: 7, costBasis: 743.8)
        XCTAssertEqual(holdings.count, 1)
        XCTAssertEqual(holdings[0].quantity, expectedHoldingOfAAPL.quantity)
        XCTAssertEqual(holdings[0].costBasis, expectedHoldingOfAAPL.costBasis)
    }

    // MARK: Test Protocol Conformances

    func testEquatable() {
        // Test with equal quantity
        var holding1 = Holding(symbol: Self.symbol)
        holding1.quantity = 5
        var holding2 = holding1
        holding2.quantity = 5
        XCTAssertEqual(holding1, holding2)

        // Test with different quantities
        holding1.quantity = 3
        XCTAssertNotEqual(holding1, holding2)
    }

    func testComparable() {
        let holding1 = Holding(symbol: Symbol("AAPL")!) //swiftlint:disable:this force_unwrapping
        let holding2 = Holding(symbol: Symbol("KO")!) //swiftlint:disable:this force_unwrapping
        let sortedHoldings = [holding2, holding1].sorted()
        XCTAssertEqual(sortedHoldings, [holding1, holding2])
    }
}