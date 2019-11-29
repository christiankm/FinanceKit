//
//  Transaction.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 19/10/2019.
//  Copyright © 2019 Christian Mitteldorf. All rights reserved.
//

import Foundation

public enum TransactionType: Int, Codable {
    case buy
    case sell
    // TODO: Add support for dividends
//    case dividend
}

public struct Transaction: Codable {

    public let type: TransactionType
    public let symbol: Symbol
    public let date: Date
    public let price: Price
    public let quantity: Quantity

    public var transactionCost: Price {
        var cost = Decimal(quantity) * price
        if type == .buy {
            cost *= -1
        }

        return cost
    }

    public init(type: TransactionType, symbol: Symbol, date: Date, price: Price, quantity: Quantity) {
        self.type = type
        self.symbol = symbol
        self.date = date
        self.price = price
        self.quantity = quantity
    }
}
