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

    /// The average purchase price per share.
    public var averageCostPerShare: Price {
        costBasis / Decimal(quantity)
    }

    public var displayName: String {
        company?.name ?? symbol.rawValue
    }

    public var currentValue: Price

    public init(symbol: Symbol, quantity: Quantity = 0, costBasis: Price = 0, currentValue: Price = 0) {
        self.symbol = symbol
        self.quantity = quantity
        self.costBasis = costBasis
        self.currentValue = currentValue
    }

    public var change: Change {
        Change(cost: costBasis, currentValue: currentValue)
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
