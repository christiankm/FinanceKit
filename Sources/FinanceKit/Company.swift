//
//  Company.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 16/06/2016.
//  Copyright © 2016 Christian Mitteldorf. All rights reserved.
//

import Foundation

/// Company.
public struct Company: Codable, Equatable, Hashable {
    public let symbol: Symbol
    public let name: String
    public let currency: Currency

    public init(symbol: Symbol, name: String, currency: Currency) {
        self.symbol = symbol
        self.name = name
        self.currency = currency
    }
}

extension Company: Comparable {

    public static func < (lhs: Company, rhs: Company) -> Bool {
        lhs.name < rhs.name
    }
}
