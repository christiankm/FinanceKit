//
//  Transaction.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 19/10/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public enum TransactionType: Int, CaseIterable, Codable {
    case buy
    case sell
    case dividend
}

public struct Transaction: Codable, Hashable {

    public let type: TransactionType
    public let symbol: Symbol
    public let date: Date
    public let price: Price
    public let quantity: Quantity
    public let commission: Price

    public var transactionCost: Price {
        var cost = Decimal(quantity) * price
        switch type {
        case .buy:
            cost += commission
            cost *= -1
        case .sell:
            cost += commission
        case .dividend:
            break
        }

        return cost
    }

    public init(type: TransactionType, symbol: Symbol, date: Date,
                price: Price, quantity: Quantity, commission: Price = 0) {
        self.type = type
        self.symbol = symbol
        self.date = date
        self.price = price
        self.quantity = quantity
        self.commission = commission
    }
}

extension Transaction: Comparable {

    public static func < (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.date < rhs.date
    }
}
