//
//  Holding.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 28/10/2019.
//  Copyright © 2019 Mitteldorf. All rights reserved.
//

import Foundation

public struct Holding: Identifiable, Equatable, Codable {

    /// A unique identifier that identifies this holding.
    public let id: UUID = UUID()

    public let symbol: Symbol

    public var company: Company?

    public var quantity: Quantity

    /// The total cost basis for all transactions.
    public var costBasis: Price
    public var costBasisInLocalCurrency: Price

    public internal(set) var commissionPaid: Price = 0

    /// The average purchase price per share.
    public var averageCostPerShare: Price {
        costBasis / Decimal(quantity)
    }

    public var displayName: String {
        company?.name ?? symbol.rawValue
    }

    public var currentValue: Price
    public var currentValueInLocalCurrency: Price

    public init(symbol: Symbol, quantity: Quantity = 0, costBasis: Price = 0,
                costBasisInLocalCurrency: Price = 0, currentValue: Price = 0,
                currentValueInLocalCurrency: Price = 0) {
        self.symbol = symbol
        self.quantity = quantity
        self.costBasis = costBasis
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

        var holdings: [Holding] = []
        transactions.forEach { transaction in
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
                    break
                }

                holdings.append(holding)
            }
        }

        return holdings.filter { $0.quantity > 0 }
    }

    /// Updates the holding with the current price of the specified stock.
    /// Also updates the `company` to reflect the stock.
    ///
    ///  This function is useful for updating the holding with the result of a query from a Stock API, without you having to calculate this yourself.
    ///
    /// - Parameter stock: A stock containing the most recent price, and company details.
    ///   The symbol must match the holding.
    /// - Returns: The newly updated holding.
    public mutating func update(with stock: Stock) -> Holding {
        guard stock.symbol == symbol else { return self }

        company = stock.company
        currentValue = stock.price * Decimal(quantity)

        return self
    }

    /// Updates the holdings currenct value and cost basis in local currencies, using the companys currency as the base currency.
    /// - Parameter currencyPairs: The current rates to convert the currency with.
    /// - Returns: If the holdings company has a currency, and a matching currency pair, it returns the converted holding, otherwise it returns a holding where the local values is equal to the base values.
    public mutating func update(with currencyPairs: [CurrencyPair], from baseCurrency: Currency) -> Holding {
        guard let companyCurrency = company?.currency else { return self }

        if companyCurrency != baseCurrency {
            if let pair = currencyPairs.first(where: { $0.baseCurrency == baseCurrency && $0.secondaryCurrency == companyCurrency }) {
                currentValueInLocalCurrency = currentValue * (1 / pair.rate)
                costBasisInLocalCurrency = costBasis * (1 / pair.rate)
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
