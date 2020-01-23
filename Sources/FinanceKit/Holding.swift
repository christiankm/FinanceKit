//
//  Holding.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 28/10/2019.
//  Copyright © 2019 Mitteldorf. All rights reserved.
//

import Foundation

public struct Holding: Identifiable, Codable {

    public let id: UUID = UUID()

    public let symbol: Symbol

    public var company: Company?

    public var quantity: Quantity

    /// The total cost basis for all transactions.
    public var costBasis: Price
    public var costBasisInLocalCurrency: Price

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

                if holding.quantity > 0 {
                    holdings.append(holding)
                }
            } else {
                var holding = Holding(symbol: symbol, quantity: quantity)
                if transaction.type == .buy && holding.quantity > 0 {
                    holding.costBasis = costBasis
                    holdings.append(holding)
                }
            }
        }

        return holdings
    }
}

extension Holding: Equatable {

    public static func == (lhs: Holding, rhs: Holding) -> Bool {
        lhs.id == rhs.id &&
        lhs.symbol == rhs.symbol &&
        lhs.quantity == rhs.quantity
    }
}

extension Holding: Comparable {

    public static func < (lhs: Holding, rhs: Holding) -> Bool {
        lhs.displayName < rhs.displayName
    }
}
