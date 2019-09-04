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
}

public extension Stock {

    init(symbol: Symbol) {
        self.symbol = symbol
        self.company = Company(symbol: symbol, name: "Apple Inc.", marketCap: "123", exchange: "NASDAQ", currency: Currency(code: .USD))
    }
}
