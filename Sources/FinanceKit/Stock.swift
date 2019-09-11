//
//  Stock.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 17/05/2017.
//  Copyright © 2017 Christian Mitteldorf. All rights reserved.
//

import Foundation

public struct Stock: Identifiable, Codable {

    public let id: UUID = UUID()
    public let symbol: Symbol
    public let company: Company
    public let price: Decimal
    public let currency: Currency
    public let change: Change

    public init(symbol: Symbol, company: Company, price: Decimal, currency: Currency, change: Change) {
        self.symbol = symbol
        self.company = company
        self.price = price
        self.currency = currency
        self.change = change
    }
}
