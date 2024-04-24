//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import FinanceKit
import XCTest

class PortfolioTests: XCTestCase {

    func testInit() {
        let portfolio = Portfolio(name: "Test Portfolio", currency: .danishKroner, holdings: [])
        XCTAssertEqual(portfolio.name, "Test Portfolio")
        XCTAssertEqual(portfolio.currency, .danishKroner)
        XCTAssertEqual(portfolio.holdings.count, 0)
    }

    func testTotalCostOfHoldings() {
        let holdings: [Holding] = [
            Holding(
                symbol: .aapl,
                quantity: 16,
                costBasis: 13,
                costBasisInLocalCurrency: 0,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            ),
            Holding(
                symbol: .coke,
                quantity: 22,
                costBasis: 12.83,
                costBasisInLocalCurrency: 0,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            ),
            Holding(
                symbol: .cake,
                quantity: 5,
                costBasis: 44.21,
                costBasisInLocalCurrency: 0,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            )
        ]
        let totalCost = Portfolio.totalCost(of: holdings).rounded
        XCTAssertEqual(totalCost, Decimal(70.04).rounded)
    }

    func testTotalCostInLocalCurrencyOfHoldings() {
        let holdings: [Holding] = [
            Holding(
                symbol: .aapl,
                quantity: 16,
                costBasis: 0,
                costBasisInLocalCurrency: 13,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            ),
            Holding(
                symbol: .coke,
                quantity: 22,
                costBasis: 0,
                costBasisInLocalCurrency: 12.83,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            ),
            Holding(
                symbol: .cake,
                quantity: 5,
                costBasis: 0,
                costBasisInLocalCurrency: 44.21,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            )
        ]
        let totalCost = Portfolio.totalCostInLocalCurrency(of: holdings).rounded
        XCTAssertEqual(totalCost, Decimal(70.04).rounded)
    }

    // MARK: Test Update and mutating functions

    func testUpdateWithStock() {
        let holdings: [Holding] = [
            Holding(
                symbol: .aapl,
                quantity: 16,
                costBasis: 0,
                costBasisInLocalCurrency: 13,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            ),
            Holding(
                symbol: .coke,
                quantity: 22,
                costBasis: 0,
                costBasisInLocalCurrency: 12.83,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            ),
            Holding(
                symbol: .cake,
                quantity: 5,
                costBasis: 0,
                costBasisInLocalCurrency: 44.21,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            )
        ]
        let portfolio = Portfolio(id: UUID(), name: "", currency: .usDollars, holdings: holdings)
        var stock = Stock.apple
        stock.price = 180

        let sut = portfolio.update(with: stock)

        let appleHolding = sut.holdings.first { $0.symbol == .aapl }
        let cakeHolding = sut.holdings.first { $0.symbol == .cake }
        let cokeHolding = sut.holdings.first { $0.symbol == .coke }

        XCTAssertEqual(sut.holdings.count, holdings.count)
        XCTAssertEqual(appleHolding?.currentValue, 2880)
        XCTAssertEqual(cakeHolding?.currentValue, 0)
        XCTAssertEqual(cokeHolding?.currentValue, 0)
    }

    func testUpdateWithStocks() throws {
        let holdings: [Holding] = [
            Holding(
                symbol: .aapl,
                quantity: 16,
                costBasis: 0,
                costBasisInLocalCurrency: 13,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            ),
            Holding(
                symbol: .coke,
                quantity: 22,
                costBasis: 0,
                costBasisInLocalCurrency: 12.83,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            ),
            Holding(
                symbol: .cake,
                quantity: 5,
                costBasis: 0,
                costBasisInLocalCurrency: 44.21,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            )
        ]
        let portfolio = Portfolio(id: UUID(), name: "", currency: .usDollars, holdings: holdings)

        var appleStock = Stock.apple
        appleStock.price = 182.00
        var cakeStock = Stock.cake
        cakeStock.price = 43.22

        // Only update two of them, to test no holdings are removed
        let stocks = [appleStock, cakeStock]
        let sut = portfolio.update(with: stocks)

        let appleHolding = try XCTUnwrap(sut.holdings.first { $0.symbol == .aapl })
        let cakeHolding = try XCTUnwrap(sut.holdings.first { $0.symbol == .cake })
        let cokeHolding = try XCTUnwrap(sut.holdings.first { $0.symbol == .coke })

        XCTAssertEqual(sut.holdings.count, holdings.count)
        XCTAssertEqual(appleHolding.currentValue, 2912.00)
        XCTAssertEqual(cakeHolding.currentValue, 216.10)
        XCTAssertEqual(cokeHolding.currentValue, 0.00)
    }

    func testAdjustForSplits() throws {
        let transactions = [
            Transaction(type: .buy, symbol: .aapl, date: .jan3, price: 100, quantity: 20, commission: 13),
            Transaction(type: .buy, symbol: .aapl, date: .jan8, price: 50, quantity: 30, commission: 13),
            Transaction(type: .buy, symbol: .cake, date: .jan9, price: 59, quantity: 20, commission: 4)
        ]

        let holdings = Holding.makeHoldings(with: transactions)
        var sut = Portfolio(id: UUID(), name: "", currency: .usDollars, holdings: holdings)

        sut.adjust(for: [
            Split(symbol: .aapl, date: .jan7, ratio: 2)
        ])

        let appleHolding = try XCTUnwrap(sut.holdings.first { $0.symbol == .aapl })

        XCTAssertEqual(sut.holdings.count, holdings.count)
        XCTAssertEqual(appleHolding.quantity, 40)
    }

    func testUpdateWithCurrencyPairsToBaseCurrency() throws {
        let holdings: [Holding] = [
            Holding(
                symbol: .aapl,
                quantity: 16,
                costBasis: 200,
                costBasisInLocalCurrency: 0,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            ),
            Holding(
                symbol: .cake,
                quantity: 5,
                costBasis: 400,
                costBasisInLocalCurrency: 0,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            ),
            Holding(
                symbol: .coke,
                quantity: 22,
                costBasis: 300,
                costBasisInLocalCurrency: 0,
                currentValue: 0,
                currentValueInLocalCurrency: 0
            )
        ]

        let currencyPairs = [
            CurrencyPair(baseCurrency: .danishKroner, secondaryCurrency: .usDollars, rate: 0.145)
        ]

        let portfolio = Portfolio(id: UUID(), name: "", currency: .usDollars, holdings: holdings)

        var sut = portfolio.update(with: [.apple, .cake, .coke])
        sut = sut.update(with: currencyPairs, to: .danishKroner)

        let appleHolding = try XCTUnwrap(sut.holdings.first { $0.symbol == .aapl })
        let cakeHolding = try XCTUnwrap(sut.holdings.first { $0.symbol == .cake })
        let cokeHolding = try XCTUnwrap(sut.holdings.first { $0.symbol == .coke })

        XCTAssertEqual(sut.holdings.count, holdings.count)
        XCTAssertEqual(appleHolding.costBasisInLocalCurrency.rounded, 1379.31)
        XCTAssertEqual(appleHolding.currentValueInLocalCurrency.rounded, 19862.07)
        XCTAssertEqual(cakeHolding.costBasisInLocalCurrency.rounded, 2758.62)
        XCTAssertEqual(cakeHolding.currentValueInLocalCurrency.rounded, 1482.76)
        XCTAssertEqual(cokeHolding.costBasisInLocalCurrency.rounded, Decimal(2068.97).rounded)
        XCTAssertEqual(cokeHolding.currentValueInLocalCurrency.rounded, 6827.59)
    }
}
