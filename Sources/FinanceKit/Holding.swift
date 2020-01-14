//
//  Holding.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 28/10/2019.
//  Copyright © 2019 Christian Mitteldorf. All rights reserved.
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

    public init(symbol: Symbol, quantity: Quantity = 0, costBasis: Price = 0, costBasisInLocalCurrency: Price = 0, currentValue: Price = 0, currentValueInLocalCurrency: Price = 0) {
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
}

extension Holding: Equatable {

    public static func == (lhs: Holding, rhs: Holding) -> Bool {
        lhs.id == rhs.id
    }
}

extension Holding: Comparable {

    public static func < (lhs: Holding, rhs: Holding) -> Bool {
        lhs.displayName < rhs.displayName
    }
}
