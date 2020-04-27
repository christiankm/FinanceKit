//
//  PortfolioTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 23/01/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import XCTest
import FinanceKit

class PortfolioTests: XCTestCase {

    func testInit() {
        let portfolio = Portfolio(name: "Test Portfolio", currency: .danishKroner, holdings: [])
        XCTAssertEqual(portfolio.name, "Test Portfolio")
        XCTAssertEqual(portfolio.currency, .danishKroner)
        XCTAssertEqual(portfolio.holdings.count, 0)
    }

    func testTotalCostOfHoldings() {
        let holdings: [Holding] = [
            Holding(symbol: .aapl, quantity: 16, costBasis: 13, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0),
            Holding(symbol: .ko, quantity: 22, costBasis: 12.83, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0),
            Holding(symbol: .cake, quantity: 5, costBasis: 44.21, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0)
        ]
        let totalCost = Portfolio.totalCost(of: holdings).rounded
        XCTAssertEqual(totalCost, Decimal(70.04).rounded)
    }

    func testTotalCostInLocalCurrencyOfHoldings() {
        let holdings: [Holding] = [
            Holding(symbol: .aapl, quantity: 16, costBasis: 0, costBasisInLocalCurrency: 13, currentValue: 0, currentValueInLocalCurrency: 0),
            Holding(symbol: Symbol(rawValue: "KO")!, quantity: 22, costBasis: 0, costBasisInLocalCurrency: 12.83, currentValue: 0, currentValueInLocalCurrency: 0),
            Holding(symbol: Symbol(rawValue: "CAKE")!, quantity: 5, costBasis: 0, costBasisInLocalCurrency: 44.21, currentValue: 0, currentValueInLocalCurrency: 0)
        ]
        let totalCost = Portfolio.totalCostInLocalCurrency(of: holdings).rounded
        XCTAssertEqual(totalCost, Decimal(70.04).rounded)
    }

    // MARK: Test Update and mutating functions

    func testUpdateWithStock() {
        let holdings: [Holding] = [
            Holding(symbol: .aapl, quantity: 16, costBasis: 0, costBasisInLocalCurrency: 13, currentValue: 0, currentValueInLocalCurrency: 0),
            Holding(symbol: .ko, quantity: 22, costBasis: 0, costBasisInLocalCurrency: 12.83, currentValue: 0, currentValueInLocalCurrency: 0),
            Holding(symbol: .cake, quantity: 5, costBasis: 0, costBasisInLocalCurrency: 44.21, currentValue: 0, currentValueInLocalCurrency: 0)
        ]
        var sut = Portfolio(id: UUID(), name: "", currency: .usDollars, holdings: holdings)
        var stock = Stock.apple
        stock.price = 180

        sut.update(with: stock)

        let appleHolding = sut.holdings.first { $0.symbol == .aapl }
        let cakeHolding = sut.holdings.first { $0.symbol == .cake }
        let cokeHolding = sut.holdings.first { $0.symbol == .ko }

        XCTAssertEqual(sut.holdings.count, holdings.count)
        XCTAssertEqual(appleHolding?.currentValue, 2_880)
        XCTAssertEqual(cakeHolding?.currentValue, 0)
        XCTAssertEqual(cokeHolding?.currentValue, 0)
    }

    func testUpdateWithStocks() {
        let holdings: [Holding] = [
            Holding(symbol: .aapl, quantity: 16, costBasis: 0, costBasisInLocalCurrency: 13, currentValue: 0, currentValueInLocalCurrency: 0),
            Holding(symbol: .ko, quantity: 22, costBasis: 0, costBasisInLocalCurrency: 12.83, currentValue: 0, currentValueInLocalCurrency: 0),
            Holding(symbol: .cake, quantity: 5, costBasis: 0, costBasisInLocalCurrency: 44.21, currentValue: 0, currentValueInLocalCurrency: 0)
        ]
        var sut = Portfolio(id: UUID(), name: "", currency: .usDollars, holdings: holdings)

        var appleStock = Stock.apple
        appleStock.price = 182.00
        var cakeStock = Stock.cake
        cakeStock.price = 43.22

        // Only update two of them, to test no holdings are removed
        let stocks = [appleStock, cakeStock]
        sut.update(with: stocks)

        let appleHolding = sut.holdings.first { $0.symbol == .aapl }!
        let cakeHolding = sut.holdings.first { $0.symbol == .cake }!
        let cokeHolding = sut.holdings.first { $0.symbol == .ko }!

        XCTAssertEqual(sut.holdings.count, holdings.count)
        XCTAssertEqual(appleHolding.currentValue, 2_912.00)
        XCTAssertEqual(cakeHolding.currentValue, 216.10)
        XCTAssertEqual(cokeHolding.currentValue, 0.00)
    }

    func testUpdateWithCurrencyPairsToBaseCurrency() {
        let holdings: [Holding] = [
            Holding(symbol: .aapl, quantity: 16, costBasis: 200, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0),
            Holding(symbol: .cake, quantity: 5, costBasis: 400, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0),
            Holding(symbol: .ko, quantity: 22, costBasis: 300, costBasisInLocalCurrency: 0, currentValue: 0, currentValueInLocalCurrency: 0)
        ]

        let currencyPairs = [
            CurrencyPair(baseCurrency: .usDollars, secondaryCurrency: .danishKroner, rate: 7.0)
        ]

        var sut = Portfolio(id: UUID(), name: "", currency: .usDollars, holdings: holdings)

        sut.update(with: [.apple, .cake, .coke])
        sut.update(with: currencyPairs, to: .danishKroner)

        let appleHolding = sut.holdings.first { $0.symbol == .aapl }!
        let cakeHolding = sut.holdings.first { $0.symbol == .cake }!
        let cokeHolding = sut.holdings.first { $0.symbol == .ko }!

        XCTAssertEqual(sut.holdings.count, holdings.count)
        XCTAssertEqual(appleHolding.costBasisInLocalCurrency, 1400)
        XCTAssertEqual(appleHolding.currentValueInLocalCurrency, 20160)
        XCTAssertEqual(cakeHolding.costBasisInLocalCurrency, 2800)
        XCTAssertEqual(cakeHolding.currentValueInLocalCurrency, 1505)
        XCTAssertEqual(cokeHolding.costBasisInLocalCurrency, 2100)
        XCTAssertEqual(cokeHolding.currentValueInLocalCurrency, 6930)
    }
}
