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
        holding.company = Company(symbol: Self.symbol, name: "Apple Inc.", currency: Currency(code: CurrencyCode(rawValue: "USD")))
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
        let aapl = Symbol("AAPL")! //swiftlint:disable:this force_unwrapping
        let cake = Symbol("CAKE")! //swiftlint:disable:this force_unwrapping
        let transactions = [
            Transaction(type: .sell, symbol: aapl, date: tomorrow, price: 120, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: aapl, date: tomorrow, price: 120, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: aapl, date: tomorrow, price: 120, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: cake, date: tomorrow, price: 60, quantity: 10, commission: 13),
            Transaction(type: .sell, symbol: aapl, date: tomorrow, price: 120, quantity: 5, commission: 13),
            Transaction(type: .buy, symbol: aapl, date: today, price: 100, quantity: 20, commission: 13),
            Transaction(type: .buy, symbol: cake, date: today, price: 60, quantity: 10, commission: 13)
        ]

        let holdings = Holding.makeHoldings(with: transactions)

        XCTAssertEqual(holdings.count, 0)
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

    // MARK: Test Update and mutating functions

    func testUpdateWithStock() {
        let aapl = Symbol("AAPL")! //swiftlint:disable:this force_unwrapping
        let currency = Currency(code: CurrencyCode(rawValue: "USD"))
        var holding = Holding(symbol: aapl, quantity: 10, costBasis: 1000)
        let stock = Stock(
            symbol: aapl,
            company: Company(symbol: aapl, name: "Apple Inc.", currency: currency),
            price: 190,
            currency: Currency(code: CurrencyCode(rawValue: "USD"))
        )

        let newHolding = holding.update(with: stock)

        XCTAssertEqual(newHolding.quantity, 10)
        XCTAssertEqual(newHolding.company?.name, "Apple Inc.")
        XCTAssertEqual(newHolding.company?.currency, Currency(code: CurrencyCode(rawValue: "USD")))
        XCTAssertEqual(newHolding.currentValue, 1900)
        XCTAssertEqual(newHolding.change.amount, 900)
    }

    func testUpdateWithStockWithDifferentSymbol() {
        let aapl = Symbol("AAPL")! //swiftlint:disable:this force_unwrapping
        let cake = Symbol("CAKE")! //swiftlint:disable:this force_unwrapping
        let currency = Currency(code: CurrencyCode(rawValue: "USD"))
        var holding = Holding(symbol: aapl, quantity: 10, costBasis: 100)
        let stock = Stock(
            symbol: cake,
            company: Company(symbol: cake, name: "Cheesecake Factory", currency: currency),
            price: 190,
            currency: Currency(code: CurrencyCode(rawValue: "USD"))
        )

        let newHolding = holding.update(with: stock)

        XCTAssertEqual(holding, newHolding)
    }

    func testUpdateWithCurrencyPairsToBaseCurrency() {
        var sut = Holding(symbol: .aapl, quantity: 10, costBasis: 1000)
        let stock = Stock.apple
        let currencyPairs = [
            CurrencyPair(baseCurrency: .danishKroner, secondaryCurrency: .usDollars, rate: 0.145)
        ]

        _ = sut.update(with: stock)
        _ = sut.update(with: currencyPairs, to: .danishKroner)

        XCTAssertEqual(sut.costBasisInLocalCurrency.rounded, 6896.55)
        XCTAssertEqual(sut.currentValueInLocalCurrency.rounded, 12413.79)
    }

    func testUpdateWithCurrencyPairsToBaseCurrencyWhenCurrencyIsEqual() {
        var sut = Holding(symbol: .aapl, quantity: 10, costBasis: 1000)
        let stock = Stock.apple
        let currencyPairs = [
            CurrencyPair(baseCurrency: .usDollars, secondaryCurrency: .danishKroner, rate: 7.0)
        ]

        _ = sut.update(with: stock)
        _ = sut.update(with: currencyPairs, to: .usDollars)

        XCTAssertEqual(sut.costBasisInLocalCurrency, 1000)
        XCTAssertEqual(sut.currentValueInLocalCurrency, 1800)
    }

    func testUpdateWithCurrencyPairsToBaseCurrencyWhenHoldingHasNoCompanyCurrency() {
        var sut = Holding(symbol: .aapl, quantity: 10, costBasis: 1000)
        let currencyPairs = [
            CurrencyPair(baseCurrency: .usDollars, secondaryCurrency: .danishKroner, rate: 7.0)
        ]

        _ = sut.update(with: currencyPairs, to: .danishKroner)

        XCTAssertEqual(sut.costBasisInLocalCurrency, 0)
        XCTAssertEqual(sut.currentValueInLocalCurrency, 0)
    }

    // MARK: Test Protocol Conformances

    func testEquatable() {
        // Test with equal quantity
        var holding1 = Holding(symbol: Self.symbol)
        holding1.quantity = 5
        holding1.currentValue = 1000
        var holding2 = holding1
        holding2.quantity = 5
        holding2.currentValue = 1000
        XCTAssertEqual(holding1, holding2)

        // Test with different quantities
        holding1.quantity = 3
        holding1.currentValue = 2000
        XCTAssertNotEqual(holding1, holding2)
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
