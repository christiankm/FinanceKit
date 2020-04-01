//
//  Portfolio.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 15/09/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public struct Portfolio: Codable, Hashable, Identifiable {
    public let id: UUID = UUID()
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

    public var change: Change {
        var totalCost: Price = 0
        holdings.forEach {
            totalCost += $0.costBasis
        }

        return Change(cost: totalCost, currentValue: currentValue)
    }

    public var changeInLocalCurrency: Change {
        var totalCost: Price = 0
        holdings.forEach {
            totalCost += $0.costBasisInLocalCurrency
        }

        return Change(cost: totalCost, currentValue: currentValueInLocalCurrency)
    }

    public init(name: String, currency: Currency, holdings: [Holding] = []) {
        self.name = name
        self.currency = currency
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

    /// Updates all holdings in the portfolio with the current price of the specified stock.
    /// Also updates the `company` to reflect the stock.
    ///
    ///  This function is useful for updating the holdings with the result of a query
    ///  from a Stock API, without you having to calculate this yourself.
    ///
    /// - Parameter stock: A stock containing the most recent price, and company details.
    ///   The symbol must match the holding.
    /// - Returns: The newly updated portfolio.
    public mutating func update(with stock: Stock) -> Portfolio {
        var updatedHoldings: [Holding] = []
        holdings.forEach { holding in
            var holdingToUpdate = holding
            updatedHoldings.append(holdingToUpdate.update(with: stock))
        }

        return self
    }

    /// Updates all holdings current value and cost basis in local currencies,
    /// using the companys currency as the base currency.
    /// - Parameter currencyPairs: The current rates to convert the currency with.
    /// - Returns: If the holdings companies has a currency, and a matching currency pair,
    /// it returns the converted portfolio, otherwise it returns a portfolio where the local values
    /// is equal to the base values.
    public mutating func update(with currencyPairs: [CurrencyPair], from baseCurrency: Currency) -> Portfolio {

        var updatedHoldings: [Holding] = []
        holdings.forEach { holding in
            var holdingToUpdate = holding
            updatedHoldings.append(holdingToUpdate.update(with: currencyPairs, from: baseCurrency))
        }

        return self
    }
}
