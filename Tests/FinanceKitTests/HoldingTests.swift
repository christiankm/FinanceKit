//
//  HoldingTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 23/01/2020.
//

import XCTest
@testable import FinanceKit

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

    func testHoldingQuantityIsClampedToZero() {
        var holding = Holding(symbol: Symbol(rawValue: "AAPL")!) //swiftlint:disable:this force_unwrapping

        holding.quantity = 5
        XCTAssertEqual(holding.quantity, 5)

        holding.quantity = -5
        XCTAssertEqual(holding.quantity, 0)
    }

    func testHoldingCostBasisIsClampedToZero() {
        var holding = Holding(symbol: Symbol(rawValue: "AAPL")!) //swiftlint:disable:this force_unwrapping

        holding.costBasis = 5
        XCTAssertEqual(holding.costBasis, 5)

        holding.costBasis = -5
        XCTAssertEqual(holding.costBasis, 0)
    }

    func testCostBasis() {
        let holding = Holding(symbol: Self.symbol, quantity: 10, costBasis: 16)
        XCTAssertEqual(holding.costBasis, 16)
    }

    func testAdjustedCostBasis() {
        var holding = Holding(symbol: Self.symbol, quantity: 10, costBasis: 160)
        holding.accumulatedDividends = 30
        XCTAssertEqual(holding.adjustedCostBasis, 130)
    }

    func testAverageCostPerShare() {
        let holding = Holding(symbol: Self.symbol, quantity: 10, costBasis: 16)
        XCTAssertEqual(holding.averageCostPerShare, 1.6)
    }

    func testAverageAdjustedCostBasisPerShare() {
        var holding = Holding(symbol: Self.symbol, quantity: 10, costBasis: 160)
        holding.accumulatedDividends = 30
        XCTAssertEqual(holding.averageAdjustedCostPerShare, 13)
    }

    func testOwnership() {
        var sut = Holding(symbol: .aapl, quantity: 10_000)
        var stock = Stock.apple
        stock.shares = 400_000_000

        sut = sut.update(with: stock)

        XCTAssertEqual(sut.ownership.rawValue, 0.000025)
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
        holding.company = Company(symbol: Self.symbol, name: "Apple Inc.", currency: Currency.usDollars)
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

        let expectedHoldingOfCAKE = Holding(symbol: cake, quantity: 10, costBasis: 613)
        XCTAssertEqual(holdings.count, 1)
        XCTAssertEqual(holdings[0].quantity, expectedHoldingOfCAKE.quantity)
        XCTAssertEqual(holdings[0].costBasis, expectedHoldingOfCAKE.costBasis)
    }

    func testMakeHoldingsWithBuyAndSellTransactionsInUnsortedOrder() {
        let today = Date()
        let tomorrow = today.addingTimeInterval(86400)
        let transactions = [
            Transaction(type: .sell, symbol: .aapl, date: tomorrow, price: 120, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: .aapl, date: tomorrow, price: 120, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: .aapl, date: tomorrow, price: 120, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: .cake, date: tomorrow, price: 60, quantity: 10, commission: 13),
            Transaction(type: .sell, symbol: .aapl, date: tomorrow, price: 120, quantity: 5, commission: 13),
            Transaction(type: .buy, symbol: .aapl, date: today, price: 100, quantity: 20, commission: 13),
            Transaction(type: .buy, symbol: .cake, date: today, price: 60, quantity: 10, commission: 13)
        ]

        let holdings = Holding.makeHoldings(with: transactions)

        XCTAssertEqual(holdings.count, 0)
    }

    func testMakeHoldingsWithOnlyDividendTransactions() {
        let transactions = [
            Transaction(type: .dividend, symbol: .aapl, date: Date(), price: 0.4, quantity: 5),
            Transaction(type: .dividend, symbol: .aapl, date: Date(), price: 0.4, quantity: 5),
            Transaction(type: .dividend, symbol: .cake, date: Date(), price: 0.6, quantity: 10)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        XCTAssertTrue(holdings.isEmpty)
    }

    func testMakeHoldingsWithBuyAndSellAndDividendTransactions() {
        let transactions = [
            Transaction(type: .buy, symbol: .aapl, date: Date(), price: 100, quantity: 5, commission: 13),
            Transaction(type: .buy, symbol: .aapl, date: Date(), price: 120, quantity: 5, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: Date(), price: 0.5, quantity: 10),
            Transaction(type: .sell, symbol: .aapl, date: Date(), price: 120, quantity: 3, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: Date(), price: 0.6, quantity: 7)
        ]

        let holdings = Holding.makeHoldings(with: transactions)

        XCTAssertEqual(holdings.count, 1)
        XCTAssertEqual(holdings[0].quantity, 7)
        XCTAssertEqual(holdings[0].accumulatedDividends, 9.2)
        XCTAssertEqual(holdings[0].costBasis, 753)
        XCTAssertEqual(holdings[0].adjustedCostBasis, 743.8)
        XCTAssertEqual(holdings[0].averageCostPerShare, 107.57, accuracy: 0.1)
        XCTAssertEqual(holdings[0].averageAdjustedCostPerShare, 106.25, accuracy: 0.1)
    }

    // MARK: Test Update functions

    func testUpdateWithStock() {
        let currency = Currency.usDollars
        var holding = Holding(symbol: .aapl, quantity: 10, costBasis: 1000)
        holding.accumulatedDividends = 20
        let stock = Stock(
            symbol: .aapl,
            company: .apple,
            price: 190,
            currency: currency
        )

        let newHolding = holding.update(with: stock)

        XCTAssertNotEqual(holding.id, newHolding.id)
        XCTAssertEqual(newHolding.quantity, 10)
        XCTAssertNotNil(newHolding.stock)
        XCTAssertEqual(newHolding.stock, stock)
        XCTAssertEqual(newHolding.company?.name, "Apple Inc.")
        XCTAssertEqual(newHolding.company?.currency, .usDollars)
        XCTAssertEqual(newHolding.currentValue, 1900)
        XCTAssertEqual(newHolding.change.amount, 900)
        XCTAssertEqual(newHolding.costBasis, 1000)
        XCTAssertEqual(newHolding.costBasisInLocalCurrency, 0)
        XCTAssertEqual(newHolding.accumulatedDividends, 20)
        XCTAssertEqual(newHolding.adjustedCostBasis, 980)
        XCTAssertEqual(newHolding.averageCostPerShare, 100)
        XCTAssertEqual(newHolding.averageAdjustedCostPerShare, 98)
    }

    func testUpdateWithStockWithDifferentSymbol() {
        let aapl = Symbol.aapl
        let cake = Symbol.cake
        let currency = Currency.usDollars
        var holding = Holding(symbol: aapl, quantity: 10, costBasis: 100)
        holding.accumulatedDividends = 20
        let stock = Stock(
            symbol: cake,
            company: Company(symbol: cake, name: "Cheesecake Factory", currency: currency),
            price: 190,
            currency: .usDollars
        )

        let newHolding = holding.update(with: stock)

        XCTAssertEqual(holding, newHolding)
    }

    func testUpdateWithCurrencyPairsToBaseCurrency() {
        var holding = Holding(symbol: .aapl, quantity: 10, costBasis: 1000)
        holding.accumulatedDividends = 30

        let stock = Stock.apple
        let currencyPairs = [
            CurrencyPair(baseCurrency: .danishKroner, secondaryCurrency: .usDollars, rate: 0.145)
        ]

        var sut = holding.update(with: stock)
        sut = sut.update(with: currencyPairs, to: .danishKroner)

        XCTAssertEqual(sut.costBasisInLocalCurrency.rounded, 6896.55)
        XCTAssertEqual(sut.currentValueInLocalCurrency.rounded, 12413.79)
        XCTAssertEqual(sut.adjustedCostBasisInLocalCurrency.rounded, 6689.66, accuracy: 0.001)
    }

    func testUpdateWithCurrencyPairsToBaseCurrencyWhenCurrencyIsEqual() {
        let holding = Holding(symbol: .aapl, quantity: 10, costBasis: 1000)
        let stock = Stock.apple
        let currencyPairs = [
            CurrencyPair(baseCurrency: .usDollars, secondaryCurrency: .danishKroner, rate: 7.0)
        ]

        var sut = holding.update(with: stock)
        sut = sut.update(with: currencyPairs, to: .usDollars)

        XCTAssertEqual(sut.costBasisInLocalCurrency, 1000)
        XCTAssertEqual(sut.currentValueInLocalCurrency, 1800)
    }

    func testUpdateWithCurrencyPairsToBaseCurrencyWhenHoldingHasNoCompanyCurrency() {
        let sut = Holding(symbol: .aapl, quantity: 10, costBasis: 1000)
        let currencyPairs = [
            CurrencyPair(baseCurrency: .usDollars, secondaryCurrency: .danishKroner, rate: 7.0)
        ]

        _ = sut.update(with: currencyPairs, to: .danishKroner)

        XCTAssertEqual(sut.costBasisInLocalCurrency, 0)
        XCTAssertEqual(sut.currentValueInLocalCurrency, 0)
    }

    // MARK: Test Protocol Conformances

    func testEquatableEqualObjectsAreEqual() {
        let holding1 = Holding(symbol: Self.symbol)
        let holding2 = holding1
        XCTAssertEqual(holding1, holding2)
    }

    func testEquatableDifferentObjectsAreNotEqual() {
        let holdingC = Holding(symbol: .aapl)
        let holdingD = Holding(symbol: .aapl)
        XCTAssertNotEqual(holdingC, holdingD)
    }

    func testComparable() {
        let holding1 = Holding(symbol: Symbol("AAPL")!) //swiftlint:disable:this force_unwrapping
        let holding2 = Holding(symbol: Symbol("KO")!) //swiftlint:disable:this force_unwrapping
        let sortedHoldings = [holding2, holding1].sorted()
        XCTAssertEqual(sortedHoldings, [holding1, holding2])
    }

    // MARK: Performance Tests

    func testMakeHoldingsPerformance() {
        measure {
            let aapl = Symbol("AAPL")! //swiftlint:disable:this force_unwrapping
            let transactions = [Transaction].init(repeating: Transaction(type: .buy, symbol: aapl, date: Date(), price: 120, quantity: 5, commission: 13), count: 1_000)

            let holdings = Holding.makeHoldings(with: transactions)
            XCTAssertEqual(holdings.count, 1)
        }
    }
}
