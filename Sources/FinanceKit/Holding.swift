//
//  Holding.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 28/10/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public struct Holding: Identifiable, Hashable, Equatable, Codable {

    /// A unique identifier that identifies this holding.
    public let id = UUID()

    public let symbol: Symbol

    public var stock: Stock?
    public internal(set) var company: Company?

    public internal(set) var quantity: Quantity {
        didSet {
            quantity = max(quantity, 0)
        }
    }

    /// The total cost basis for all transactions.
    public internal(set) var costBasis: Price {
        didSet {
            costBasis = max(costBasis, 0)
        }
    }

    public internal(set) var costBasisInLocalCurrency: Price

    public internal(set) var commissionPaid: Price = 0

    /// The average purchase price per share.
    public var averageCostPerShare: Price {
        guard quantity > 0 else { return 0 }
        return costBasis / Decimal(quantity)
    }

    public var averageAdjustedCostBasisPerShare: Decimal = 0
    public var accumulatedDividends: Decimal = 0

    public var displayName: String {
        company?.name ?? symbol.rawValue
    }

    public internal(set) var currentValue: Price
    public internal(set) var currentValueInLocalCurrency: Price

    /// Returns the ownership in terms of percentage of the total amount of oustanding shares.
    public var ownership: Double {
        guard let outstandingShares = stock?.shares, outstandingShares > 0 else { return 0 }
        return Double(quantity / Int(outstandingShares))
    }

    public init(symbol: Symbol, quantity: Quantity = 0, costBasis: Price = 0,
                costBasisInLocalCurrency: Price = 0, currentValue: Price = 0,
                currentValueInLocalCurrency: Price = 0) {
        self.symbol = symbol
        self.quantity = max(quantity, 0)
        self.costBasis = max(costBasis, 0)
        self.costBasisInLocalCurrency = costBasisInLocalCurrency
        self.currentValue = currentValue
        self.currentValueInLocalCurrency = currentValueInLocalCurrency
    }

    public var change: Change {
        Change(cost: costBasis, currentValue: currentValue)
    }

    public var changeInLocalCurrency: Change {
        Change(cost: costBasisInLocalCurrency, currentValue: currentValueInLocalCurrency)
    }

    public static func makeHoldings(with transactions: [Transaction]) -> [Holding] {
        guard !transactions.isEmpty else {
            return []
        }

        // Sort transactions by date to be sure they are
        // processed in the real-time order.
        let sortedTransactions = transactions.sorted()

        var holdings: [Holding] = []
        sortedTransactions.forEach { transaction in
            let symbol = transaction.symbol
            let quantity = transaction.quantity
            let price = transaction.price
            let costBasis = price * Decimal(quantity) + transaction.commission

            // If a holding already exists for this symbol,
            // update quantity and cost basis. Else add a new holding to the array
            if var holding = holdings.first(where: { $0.symbol == symbol }) {
                holding.commissionPaid += transaction.commission

                switch transaction.type {
                case .buy:
                    holding.quantity += quantity
                    holding.costBasis += costBasis
                case .sell:
                    holding.quantity -= quantity
                    holding.costBasis -= costBasis
                case .dividend:
                    holding.costBasis -= costBasis
                    holding.accumulatedDividends += transaction.totalDividend
                }

                // Remove previous and re-add newly calculated holding
                holdings.removeAll(where: { $0.symbol == symbol })
                holdings.append(holding)
            } else {
                var holding = Holding(symbol: symbol)
                holding.commissionPaid += transaction.commission

                switch transaction.type {
                case .buy:
                    holding.quantity += quantity
                    holding.costBasis += costBasis
                case .sell:
                    break
                case .dividend:
                    holding.accumulatedDividends = transaction.totalDividend
                }

                holdings.append(holding)
            }
        }

        return holdings.filter { $0.quantity > 0 }
    }

    /// Updates the holding with the current price of the specified stock.
    /// Also updates the `company` to reflect the stock.
    ///
    ///  This function is useful for updating the holding with the result of a query
    ///  from a Stock API, without you having to calculate this yourself.
    ///
    /// - Parameter stock: A stock containing the most recent price, and company details.
    ///   The symbol must match the holding.
    /// - Returns: The newly updated holding.
    public mutating func update(with stock: Stock) -> Holding {
        guard stock.symbol == symbol else { return self }

        self.stock = stock
        self.company = stock.company
        self.currentValue = stock.price * Decimal(quantity)

        return self
    }

    /// Updates the holdings current value and cost basis in local currencies,
    /// using the companys currency as the base currency.
    /// - Parameter currencyPairs: The current rates to convert the currency with.
    /// - Returns: If the holdings company has a currency, and a matching currency pair,
    /// it returns the converted holding, otherwise it returns a holding where the local values
    /// is equal to the base values.
    public mutating func update(with currencyPairs: [CurrencyPair], from baseCurrency: Currency) -> Holding {
        guard let companyCurrency = company?.currency else { return self }

        if companyCurrency != baseCurrency {
            if let pair = currencyPairs.first(where: { $0.baseCurrency == baseCurrency && $0.secondaryCurrency == companyCurrency }) {
                currentValueInLocalCurrency = currentValue * (1 / Decimal(pair.rate))
                costBasisInLocalCurrency = costBasis * (1 / Decimal(pair.rate))
            }
        } else {
            currentValueInLocalCurrency = currentValue
            costBasisInLocalCurrency = costBasis
        }

        return self
    }
}

extension Holding: Comparable {

    public static func < (lhs: Holding, rhs: Holding) -> Bool {
        lhs.displayName < rhs.displayName
    }
}
