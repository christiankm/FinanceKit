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
    public var priceOpen: Decimal?
    public var dayHigh: Decimal?
    public var dayLow: Decimal?
    public var fiftyTwoWeekHigh: Decimal?
    public var fiftyTwoWeekLow: Decimal?
    public let currency: Currency
    public let change: Change?
    public var marketCap: UInt64?
    public var exchange: Exchange?
    public var closeYesterday: Price?
    public var volume: UInt64?
    public var volumeAvg: UInt64?
    public var shares: UInt64?
    public var timezone: String?
    public var timezoneName: String?
    public var gmtOffset: String?
    public var lastTradeTime: String?
    public var pe: Double?
    public var eps: Decimal?

    public var target: PriceTarget?
    public init(symbol: Symbol, company: Company, price: Decimal, currency: Currency,
                marketCap: UInt64? = nil, exchange: Exchange? = nil, change: Change? = nil) {
        self.symbol = symbol
        self.company = company
        self.price = price
        self.currency = currency
        self.marketCap = marketCap
        self.exchange = exchange
        self.change = change
    }
}

extension Stock: Hashable {

    public static func == (lhs: Stock, rhs: Stock) -> Bool {
        lhs.symbol == rhs.symbol
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(symbol)
    }
}

extension Stock: Comparable {

    public static func < (lhs: Stock, rhs: Stock) -> Bool {
        lhs.company < rhs.company
    }
}
