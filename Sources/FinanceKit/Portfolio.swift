//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

/// A Portfolio is a structure that contains transactions and holdings of stocks or other instruments.
public struct Portfolio: Codable, Hashable, Identifiable {

    public let id: UUID
    public let name: String
    public let currency: Currency
    public var holdings: [Holding] = []

    public var costBasis: Amount {
        holdings.reduce(0) { $0 + $1.costBasis }
    }

    public var costBasisInLocalCurrency: Amount {
        holdings.reduce(0) { $0 + $1.costBasisInLocalCurrency }
    }

    public var currentValue: Amount {
        holdings.reduce(0) { $0 + $1.currentValue }
    }

    public var currentValueInLocalCurrency: Amount {
        holdings.reduce(0) { $0 + $1.currentValueInLocalCurrency }
    }

    /// - returns: The total change for all the holdings in the portfolio.
    public var change: Change {
        var totalCost: Price = 0
        holdings.forEach { totalCost += $0.costBasis }

        return Change(cost: totalCost, currentValue: currentValue)
    }

    public var changeInLocalCurrency: Change {
        var totalCost: Price = 0
        holdings.forEach { totalCost += $0.costBasisInLocalCurrency }

        return Change(cost: totalCost, currentValue: currentValueInLocalCurrency)
    }

    // swiftlint:disable:next function_default_parameter_at_end
    public init(id: UUID = UUID(), name: String, currency: Currency, holdings: [Holding] = []) {
        self.id = id
        self.name = name
        self.currency = currency
        self.holdings = holdings
    }

    public init(portfolios: [Portfolio]) {
        self.id = UUID()
        self.name = ""
        self.currency = Currency(code: .unitedStatesDollar)

        var holdings: [Holding] = []
        portfolios.forEach { holdings.append(contentsOf: $0.holdings) }
        self.holdings = holdings
    }

    public static func totalCost(of portfolios: [Portfolio]) -> Amount {
        guard !portfolios.isEmpty else { return 0 }
        return portfolios.reduce(0) { $0 + $1.costBasis }
    }

    public static func totalCostInLocalCurrency(of portfolios: [Portfolio]) -> Amount {
        guard !portfolios.isEmpty else { return 0 }
        return portfolios.reduce(0) { $0 + $1.costBasisInLocalCurrency }
    }

    public static func totalValue(of portfolios: [Portfolio]) -> Amount {
        guard !portfolios.isEmpty else { return 0 }
        return portfolios.reduce(0) { $0 + $1.currentValue }
    }

    public static func totalValueInLocalCurrency(of portfolios: [Portfolio]) -> Amount {
        guard !portfolios.isEmpty else { return 0 }
        return portfolios.reduce(0) { $0 + $1.currentValueInLocalCurrency }
    }

    public static func totalChange(of portfolios: [Portfolio]) -> Change {
        guard !portfolios.isEmpty else { return .zero }

        let averageCost: Amount = portfolios.reduce(0) { $0 + $1.costBasis } / Decimal(portfolios.count)
        let averageValue: Amount = portfolios.reduce(0) { $0 + $1.currentValue } / Decimal(portfolios.count)

        return Change(cost: averageCost, currentValue: averageValue)
    }

    public static func totalChangeInLocalCurrency(of portfolios: [Portfolio]) -> Change {
        guard !portfolios.isEmpty else { return .zero }

        let averageCost = portfolios.reduce(0) { $0 + $1.costBasisInLocalCurrency } / Decimal(portfolios.count)
        let averageValue = portfolios.reduce(0) { $0 + $1.currentValueInLocalCurrency } / Decimal(portfolios.count)

        return Change(cost: averageCost, currentValue: averageValue)
    }

    public static func totalCost(of holdings: [Holding]) -> Amount {
        guard !holdings.isEmpty else { return 0 }
        return holdings.reduce(0) { $0 + $1.costBasis }
    }

    public static func totalCostInLocalCurrency(of holdings: [Holding]) -> Amount {
        guard !holdings.isEmpty else { return 0 }
        return holdings.reduce(0) { $0 + $1.costBasisInLocalCurrency }
    }

    public static func averageAdjustedCostPerShare(of symbol: Symbol, in transactions: [Transaction]) -> Price {
        let transactionsMatchingSymbol = transactions.filter { $0.symbol.rawValue == symbol.rawValue }
        guard let holding = Holding.makeHoldings(with: transactionsMatchingSymbol).first else { return 0 }

        return holding.averageAdjustedCostPerShare
    }

    public static func averageAdjustedCostPerShare(of symbol: Symbol, in holdings: [Holding]) -> Price {
        guard let holdingMatchingSymbol = holdings.first(where: { $0.symbol == symbol }) else { return 0 }
        return holdingMatchingSymbol.averageAdjustedCostPerShare
    }

    /// Returns a new `Portfolio` updating all holdings in the portfolio with the current price of the specified stock.
    ///
    /// This is useful for updating the holdings with the result of a query
    /// from a Stock API, without you having to calculate this yourself.
    ///
    /// - Parameter stock: A stock containing the most recent price, and company details.
    ///   The symbol must match the holding.
    public func update(with stock: Stock) -> Portfolio {
        var updatedHoldings: [Holding] = []
        holdings.forEach { holding in
            let holdingToUpdate = holding
            updatedHoldings.append(holdingToUpdate.update(with: stock))
        }

        let newPortfolio = Portfolio(
            id: UUID(),
            name: name,
            currency: currency,
            holdings: updatedHoldings
        )

        return newPortfolio
    }

    public func update(with stocks: [Stock]) -> Portfolio {
        var updatedHoldings: [Holding] = []
        stocks.forEach { stock in
            guard let holding = holdings.first(where: { $0.symbol == stock.symbol }) else { return }
            let updatedHolding = holding.update(with: stock)
            updatedHoldings.append(updatedHolding)
        }

        // Compare updated holdings and add any that did not have a price
        // This will ensure the holding is still present, but without updating the price
        holdings.forEach { holding in
            // If not found in updatedHoldings, add to updatedHoldings and update total market value
            if !updatedHoldings.contains(where: { $0.symbol == holding.symbol }) {
                updatedHoldings.append(holding)
            }
        }

        let newPortfolio = Portfolio(
            name: name,
            currency: currency,
            holdings: updatedHoldings
        )

        return newPortfolio
    }

    /// Returns a new `Portfolio` with all holdings current value and cost basis in local currencies,
    /// using the companys currency as the base currency.
    ///
    /// - Parameter currencyPairs: The current rates to convert the currency with.
    /// - Parameter baseCurrency: The local currency to convert any other values into.
    /// - Returns: If the holdings companies has a currency, and a matching currency pair,
    /// it returns the converted portfolio, otherwise it returns a portfolio where the local values
    /// is equal to the base values.
    public func update(with currencyPairs: [CurrencyPair], to baseCurrency: Currency) -> Portfolio {
        var updatedHoldings: [Holding] = []
        holdings.forEach { holding in
            let newHolding = holding.update(with: currencyPairs, to: baseCurrency)
            updatedHoldings.append(newHolding)
        }

        let newPortfolio = Portfolio(
            id: UUID(),
            name: name,
            currency: currency,
            holdings: updatedHoldings
        )

        return newPortfolio
    }
}

extension Portfolio: Equatable {

    public static func == (lhs: Portfolio, rhs: Portfolio) -> Bool {
        lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.currency == rhs.currency &&
            lhs.holdings == rhs.holdings &&
            lhs.currentValue == rhs.currentValue &&
            lhs.currentValueInLocalCurrency == rhs.currentValueInLocalCurrency &&
            lhs.change == rhs.change &&
            lhs.changeInLocalCurrency == rhs.changeInLocalCurrency
    }
}
