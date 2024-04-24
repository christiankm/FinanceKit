//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

@testable import FinanceKit
import XCTest

// swiftlint:disable:next type_body_length
class HoldingTests: XCTestCase {

    func testInitWithDefaultValues() {
        let holding = Holding(symbol: .aapl)
        XCTAssertEqual(holding.symbol.rawValue, "AAPL")
        XCTAssertEqual(holding.quantity, 0)
        XCTAssertEqual(holding.costBasis, 0)
        XCTAssertEqual(holding.costBasisInLocalCurrency, 0)
        XCTAssertEqual(holding.currentValue, 0)
        XCTAssertEqual(holding.currentValueInLocalCurrency, 0)
        XCTAssertTrue(holding.transactions.isEmpty)
    }

    func testInitWithValues() {
        let holding = Holding(
            symbol: .aapl,
            quantity: 3,
            costBasis: 12,
            costBasisInLocalCurrency: 23,
            currentValue: 23,
            currentValueInLocalCurrency: 34
        )
        XCTAssertEqual(holding.symbol.rawValue, "AAPL")
        XCTAssertEqual(holding.quantity, 3)
        XCTAssertEqual(holding.costBasis, 12)
        XCTAssertEqual(holding.costBasisInLocalCurrency, 23)
        XCTAssertEqual(holding.currentValue, 23)
        XCTAssertEqual(holding.currentValueInLocalCurrency, 34)
        XCTAssertTrue(holding.transactions.isEmpty)
    }

    func testHoldingQuantityIsClampedToZero() {
        var holding = Holding(symbol: .aapl)

        holding.quantity = 5
        XCTAssertEqual(holding.quantity, 5)

        holding.quantity = -5
        XCTAssertEqual(holding.quantity, 0)
    }

    func testHoldingCostBasisIsClampedToZero() {
        var holding = Holding(symbol: .aapl)

        holding.costBasis = 5
        XCTAssertEqual(holding.costBasis, 5)

        holding.costBasis = -5
        XCTAssertEqual(holding.costBasis, 0)
    }

    func testCostBasis() {
        let holding = Holding(symbol: .aapl, quantity: 10, costBasis: 16)
        XCTAssertEqual(holding.costBasis, 16)
    }

    func testAdjustedCostBasis() {
        var holding = Holding(symbol: .aapl, quantity: 10, costBasis: 160)
        holding.accumulatedDividends = 30
        XCTAssertEqual(holding.adjustedCostBasis, 130)
    }

    func testAverageCostPerShare() {
        let holding = Holding(symbol: .aapl, quantity: 10, costBasis: 16)
        XCTAssertEqual(holding.averageCostPerShare, 1.6)
    }

    func testAverageAdjustedCostBasisPerShare() {
        var holding = Holding(symbol: .aapl, quantity: 10, costBasis: 160)
        holding.accumulatedDividends = 30
        XCTAssertEqual(holding.averageAdjustedCostPerShare, 13)
    }

    func testOwnership() {
        var sut = Holding(symbol: .aapl, quantity: 10000)
        var stock = Stock.apple
        stock.shares = 400_000_000

        sut = sut.update(with: stock)

        XCTAssertEqual(sut.ownership.decimal, 0.000025)
    }

    func testChange() {
        let holding = Holding(
            symbol: .aapl,
            quantity: 3,
            costBasis: 12,
            costBasisInLocalCurrency: 23,
            currentValue: 23,
            currentValueInLocalCurrency: 34
        )
        let expectedChange = Change(cost: 12, currentValue: 23)
        XCTAssertEqual(holding.change, expectedChange)
    }

    func testChangeInLocalCurrency() {
        let holding = Holding(
            symbol: .aapl,
            quantity: 3,
            costBasis: 12,
            costBasisInLocalCurrency: 23,
            currentValue: 23,
            currentValueInLocalCurrency: 34
        )
        let expectedChange = Change(cost: 23, currentValue: 34)
        XCTAssertEqual(holding.changeInLocalCurrency, expectedChange)
    }

    func testReturnOnInvestment() {
        let holding = Holding(
            symbol: .aapl,
            quantity: 3,
            costBasis: 12,
            currentValue: 23
        )
        let expectedReturn = Percentage(0.916)
        XCTAssertEqual(holding.returnOnInvestment.decimal, expectedReturn.decimal, accuracy: 0.001)
    }

    func testDisplayNameWhenCompanyIsCompanyName() {
        var holding = Holding(symbol: .aapl, quantity: 10, costBasis: 16)
        holding.company = Company(symbol: .aapl, name: "Apple Inc.", currency: Currency.usDollars)
        XCTAssertEqual(holding.displayName, "Apple Inc.")
    }

    func testDisplayNameWhenNoCompanyIsSymbol() {
        let holding = Holding(symbol: .aapl, quantity: 10, costBasis: 16)
        XCTAssertEqual(holding.displayName, "AAPL")
    }

    func testDisplayNameIsSymbolIfEmptyCompanyName() {
        var holding = Holding(symbol: .aapl, quantity: 10, costBasis: 16)
        holding.company = Company(symbol: .aapl, name: "", currency: Currency.usDollars)
        XCTAssertEqual(holding.displayName, "AAPL")
    }

    // MARK: Test makeHoldings

    func testMakeHoldingsWithNoTransactions() {
        let transactions: [Transaction] = []
        let holdings = Holding.makeHoldings(with: transactions)
        XCTAssertTrue(holdings.isEmpty)
    }

    func testMakeHoldingsWithOnlyBuyTransactions() {
        let aapl = Symbol.aapl
        let cake = Symbol.cake
        let transactions = [
            Transaction(type: .buy, symbol: aapl, date: Date(), price: 100, quantity: 5, commission: 13),
            Transaction(type: .buy, symbol: aapl, date: Date(), price: 120, quantity: 5, commission: 13),
            Transaction(type: .buy, symbol: cake, date: Date(), price: 60, quantity: 10, commission: 13)
        ]

        let holdings = Holding.makeHoldings(with: transactions)

        let expectedHoldingOfAAPL = Holding(
            symbol: aapl,
            quantity: 10,
            costBasis: 1126
        )
        let expectedHoldingOfCAKE = Holding(
            symbol: cake,
            quantity: 10,
            costBasis: 613
        )
        XCTAssertEqual(holdings.count, 2)
        XCTAssertEqual(holdings[0].quantity, expectedHoldingOfAAPL.quantity)
        XCTAssertEqual(holdings[0].costBasis, expectedHoldingOfAAPL.costBasis)
        XCTAssertEqual(holdings[0].transactions.count, 2)
        XCTAssertEqual(holdings[1].quantity, expectedHoldingOfCAKE.quantity)
        XCTAssertEqual(holdings[1].costBasis, expectedHoldingOfCAKE.costBasis)
        XCTAssertEqual(holdings[1].transactions.count, 1)
    }

    func testMakeHoldingsWithOnlySellTransactions() {
        let aapl = Symbol.aapl
        let cake = Symbol.cake
        let transactions = [
            Transaction(type: .sell, symbol: aapl, date: Date(), price: 100, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: aapl, date: Date(), price: 120, quantity: 5, commission: 13),
            Transaction(type: .sell, symbol: cake, date: Date(), price: 60, quantity: 10, commission: 13)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        XCTAssertTrue(holdings.isEmpty)
    }

    func testMakeHoldingsWithBuyAndSellTransactions() {
        let aapl = Symbol.aapl
        let cake = Symbol.cake
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
        XCTAssertEqual(holdings[0].transactions.count, 1)
    }

    func testMakeHoldingsWithMultipleBuyAndSellTransactions() throws {
        let today = Date()
        let tomorrow = today.addingTimeInterval(86400)
        let transactions = [
            Transaction(type: .buy, symbol: .aapl, date: today, price: 100, quantity: 20, commission: 4),
            Transaction(type: .sell, symbol: .aapl, date: tomorrow, price: 110, quantity: 5, commission: 4),
            Transaction(type: .sell, symbol: .aapl, date: tomorrow, price: 120, quantity: 5, commission: 4),
            Transaction(type: .sell, symbol: .aapl, date: tomorrow, price: 130, quantity: 5, commission: 4)
        ]

        let holdings = Holding.makeHoldings(with: transactions)

        XCTAssertEqual(holdings.count, 1)

        let firstHolding = try XCTUnwrap(holdings.first)
        XCTAssertEqual(firstHolding.costBasis, 216)
        XCTAssertEqual(firstHolding.averageCostPerShare, 43.2)
        XCTAssertEqual(firstHolding.transactions.count, 4)
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

    func testMakeHoldingsWithBuyAndSellAndDividendTransactions() throws {
        let transactions = [
            Transaction(type: .buy, symbol: .aapl, date: Date(), price: 100, quantity: 5, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: Date(), price: 0.5, quantity: 10),
            Transaction(type: .sell, symbol: .aapl, date: Date(), price: 120, quantity: 3, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: Date(), price: 0.6, quantity: 2)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        let holding = try XCTUnwrap(holdings.first)

        XCTAssertEqual(holdings.count, 1)
        XCTAssertEqual(holding.quantity, 2)
        XCTAssertEqual(holding.accumulatedDividends, 6.2)
        XCTAssertEqual(holding.costBasis, 166)
        XCTAssertEqual(holding.adjustedCostBasis, 159.8)
        XCTAssertEqual(holding.averageCostPerShare, 83, accuracy: 0.01)
        XCTAssertEqual(holding.averageAdjustedCostPerShare, 79.9, accuracy: 0.01)
        XCTAssertEqual(holding.transactions.count, 4)
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
        XCTAssertEqual(newHolding.transactions.count, holding.transactions.count)
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
        var holding = Holding(symbol: .aapl, quantity: 10, costBasis: 100)
        holding.accumulatedDividends = 30

        let stock = Stock.apple
        let currencyPairs = [
            CurrencyPair(baseCurrency: .usDollars, secondaryCurrency: .danishKroner, rate: 1.323)
        ]

        var sut = holding.update(with: stock)
        sut = sut.update(with: currencyPairs, to: .danishKroner)

        XCTAssertEqual(sut.costBasisInLocalCurrency.rounded, 132.3)
        XCTAssertEqual(sut.currentValueInLocalCurrency.rounded, 2381.4)
        XCTAssertEqual(sut.adjustedCostBasisInLocalCurrency.rounded, 92.61)
        XCTAssertEqual(sut.transactions.count, holding.transactions.count)
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
        XCTAssertEqual(sut.transactions.count, holding.transactions.count)
    }

    func testUpdateWithCurrencyPairsToBaseCurrencyWhenHoldingHasNoCompanyCurrency() {
        let sut = Holding(symbol: .aapl, quantity: 10, costBasis: 1000)
        let currencyPairs = [
            CurrencyPair(baseCurrency: .usDollars, secondaryCurrency: .danishKroner, rate: 7.0)
        ]

        _ = sut.update(with: currencyPairs, to: .danishKroner)

        XCTAssertEqual(sut.costBasisInLocalCurrency, 0)
        XCTAssertEqual(sut.currentValueInLocalCurrency, 0)
        XCTAssertEqual(sut.transactions.count, 0)
    }

    // MARK: Test Split adjusting

    func testAdjustForSplit() throws {
        let transactions = [
            Transaction(type: .buy, symbol: .aapl, date: .jan3, price: 92.72, quantity: 7, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: .jan4, price: 0.5, quantity: 23),
            Transaction(type: .sell, symbol: .aapl, date: .jan5, price: 92.72, quantity: 3, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: .jan6, price: 0.6, quantity: 20),
            Transaction(type: .buy, symbol: .aapl, date: .jan8, price: 180.94, quantity: 11, commission: 13)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        var holding = try XCTUnwrap(holdings.first)

        holding = holding.update(with: .apple)
        XCTAssertEqual(holding.quantity, 15)
        XCTAssertEqual(holding.currentValue, 2700)

        var sut = holding

        let split = Split(symbol: .aapl, date: .jan9, ratio: 0.25)
        sut.adjustForSplit(split)

        XCTAssertEqual(sut.stock, holding.stock)
        XCTAssertEqual(sut.company, holding.company)
        XCTAssertEqual(sut.quantity, 60)
        XCTAssertEqual(sut.accumulatedDividends, holding.accumulatedDividends)
        XCTAssertEqual(sut.costBasis, holding.costBasis)
        XCTAssertEqual(sut.adjustedCostBasis, holding.adjustedCostBasis)
        XCTAssertEqual(sut.averageCostPerShare, 40.00, accuracy: 0.01)
        XCTAssertEqual(sut.averageAdjustedCostPerShare, 39.612, accuracy: 0.01)
        XCTAssertEqual(sut.currentValue, holding.currentValue)
        XCTAssertEqual(sut.currentValueInLocalCurrency, holding.currentValueInLocalCurrency)
    }

    func testAdjustForReverseSplit() throws {
        let transactions = [
            Transaction(type: .buy, symbol: .aapl, date: .jan3, price: 100, quantity: 23, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: .jan4, price: 0.5, quantity: 23),
            Transaction(type: .sell, symbol: .aapl, date: .jan5, price: 120, quantity: 3, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: .jan6, price: 0.6, quantity: 20),
            Transaction(type: .buy, symbol: .aapl, date: .jan8, price: 400, quantity: 26, commission: 13)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        var holding = try XCTUnwrap(holdings.first)

        holding = holding.update(with: .apple)
        XCTAssertEqual(holding.quantity, 46)
        XCTAssertEqual(holding.currentValue, 8280)

        var sut = holding

        let split = Split(symbol: .aapl, date: .jan7, ratio: 0.2)
        sut.adjustForSplit(split)

        XCTAssertEqual(sut.stock, holding.stock)
        XCTAssertEqual(sut.company, holding.company)
        XCTAssertEqual(sut.quantity, 126)
        XCTAssertEqual(sut.accumulatedDividends, holding.accumulatedDividends)
//        XCTAssertEqual(sut.costBasis, holding.costBasis)
//        XCTAssertEqual(sut.adjustedCostBasis, holding.adjustedCostBasis)
        XCTAssertEqual(sut.averageCostPerShare, 98.24, accuracy: 0.01)
        XCTAssertEqual(sut.averageAdjustedCostPerShare, 98.05, accuracy: 0.01)
        XCTAssertEqual(sut.currentValue, holding.currentValue)
        XCTAssertEqual(sut.currentValueInLocalCurrency, holding.currentValueInLocalCurrency)
    }

    func testAdjustForSplits() throws {
        let transactions = [
            Transaction(type: .buy, symbol: .aapl, date: .jan3, price: 100, quantity: 23, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: .jan4, price: 0.5, quantity: 23),
            Transaction(type: .sell, symbol: .aapl, date: .jan5, price: 120, quantity: 3, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: .jan6, price: 0.6, quantity: 20),
            Transaction(type: .buy, symbol: .aapl, date: .jan8, price: 50, quantity: 26, commission: 13)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        var holding = try XCTUnwrap(holdings.first)

        holding = holding.update(with: .apple)
        XCTAssertEqual(holding.quantity, 46)
        XCTAssertEqual(holding.currentValue, 8280)

        var sut = holding

        sut.adjustForSplit(Split(symbol: .aapl, date: .jan7, ratio: 2))
        sut.adjustForSplit(Split(symbol: .aapl, date: .jan8, ratio: 5))
        sut.adjustForSplit(Split(symbol: .aapl, date: .jan9, ratio: 0.5))

        XCTAssertEqual(sut.stock, holding.stock)
        XCTAssertEqual(sut.company, holding.company)
        XCTAssertEqual(sut.quantity, 14)
        XCTAssertEqual(sut.accumulatedDividends, holding.accumulatedDividends)
//        XCTAssertEqual(sut.costBasis, holding.costBasis)
//        XCTAssertEqual(sut.adjustedCostBasis, holding.adjustedCostBasis)
        XCTAssertEqual(sut.averageCostPerShare, 233.07, accuracy: 0.01)
        XCTAssertEqual(sut.averageAdjustedCostPerShare, 231.39, accuracy: 0.01)
//        XCTAssertEqual(sut.currentValue, holding.currentValue)
        XCTAssertEqual(sut.currentValueInLocalCurrency, holding.currentValueInLocalCurrency)
    }

    func testAdjustForSplitDoesNothingForFutureSplit() throws {
        let transactions = [
            Transaction(type: .buy, symbol: .aapl, date: Date(), price: 100, quantity: 5, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: Date(), price: 0.5, quantity: 10),
            Transaction(type: .sell, symbol: .aapl, date: Date(), price: 120, quantity: 3, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: Date(), price: 0.6, quantity: 2)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        let holding = try XCTUnwrap(holdings.first)
        var sut = holding

        let futureSplit = Split(symbol: .aapl, date: .distantFuture, ratio: 2)
        sut.adjustForSplit(futureSplit)

        XCTAssertEqual(sut, sut)
    }

    func testAdjustForSplitDoesNothingForInvalidSplitRatio() throws {
        let transactions = [
            Transaction(type: .buy, symbol: .aapl, date: Date(), price: 100, quantity: 5, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: Date(), price: 0.5, quantity: 10),
            Transaction(type: .sell, symbol: .aapl, date: Date(), price: 120, quantity: 3, commission: 13),
            Transaction(type: .dividend, symbol: .aapl, date: Date(), price: 0.6, quantity: 2)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        let holding = try XCTUnwrap(holdings.first)
        var sut = holding

        let zeroSplit = Split(symbol: .aapl, date: .distantPast, ratio: 0)
        sut.adjustForSplit(zeroSplit)

        XCTAssertEqual(holding, sut)

        let oneSplit = Split(symbol: .aapl, date: .distantPast, ratio: 1)
        sut.adjustForSplit(oneSplit)

        XCTAssertEqual(holding, sut)
    }

    // MARK: Test Protocol Conformances

    func testEquatableEqualObjectsAreEqual() {
        let holding1 = Holding(symbol: .aapl)
        let holding2 = holding1
        XCTAssertEqual(holding1, holding2)
    }

    func testEquatableDifferentObjectsAreNotEqual() {
        let holdingC = Holding(symbol: .aapl)
        let holdingD = Holding(symbol: .aapl)
        XCTAssertNotEqual(holdingC, holdingD)
    }

    func testComparable() {
        let holding1 = Holding(symbol: .aapl)
        let holding2 = Holding(symbol: .coke)
        let sortedHoldings = [holding2, holding1].sorted()
        XCTAssertEqual(sortedHoldings, [holding1, holding2])
    }

    // MARK: Performance Tests

    func testMakeHoldingsPerformance() {
        measure {
            let transactions = [Transaction].init(repeating: Transaction(
                type: .buy,
                symbol: .aapl,
                date: Date(),
                price: 120,
                quantity: 5,
                commission: 13
            ), count: 1000)

            let holdings = Holding.makeHoldings(with: transactions)
            XCTAssertEqual(holdings.count, 1)
        }
    }
}

// swiftlint:disable:this file_length
