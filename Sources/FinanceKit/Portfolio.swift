//
//  Portfolio.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 15/09/2019.
//  Copyright © 2017 Christian Mitteldorf. All rights reserved.
//

import Foundation

public struct Portfolio: Codable, Identifiable {
    public let id: UUID = UUID()
    public let name: String
    public let currency: Currency
    public var stocks: [Stock] = []

    public init(name: String, currency: Currency, stocks: [Stock] = []) {
        self.name = name
        self.currency = currency
        self.stocks = stocks
    }
}
