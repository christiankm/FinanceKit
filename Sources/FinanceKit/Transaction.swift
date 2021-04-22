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

    /// Total cost (or return) of the transaction.
    ///
    /// Buy transactions will have a negative cost including commission, indicating money was paid from the account.
    /// Sell transactions will have a (usually) positive cost with commissions subtracted, indicating money was deposited into the account.
    /// Dividends will be positive indicating money going into the account.
    public var transactionCost: Price {
        var cost = Decimal(quantity) * price
        switch type {
        case .buy:
            cost += commission
            cost *= -1
        case .sell:
            cost -= commission
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
