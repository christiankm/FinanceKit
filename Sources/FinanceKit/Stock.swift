//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct Stock: Asset, Identifiable, Equatable, Codable {

    public var id = UUID()
    public let symbol: Symbol
    public let company: Company
    public var price: Decimal
    public var priceOpen: Decimal?
    public var dayHigh: Decimal?
    public var dayLow: Decimal?
    public var fiftyTwoWeekHigh: Decimal?
    public var fiftyTwoWeekLow: Decimal?
    public var region: String?
    public let currency: Currency
    public var change: Change?
    public var marketCap: UInt64?
    public var exchange: Exchange?
    public var closeYesterday: Price?
    public var volume: UInt64?
    public var volumeAvg: UInt64?
    public var shares: UInt64?
    public var timezone: String?
    public var timezoneName: String?
    public var gmtOffset: String?
    public var lastTraded: Date?
    public var priceEarnings: Double?
    public var earningsPerShare: Amount?

    public var target: PriceTarget?
    public var intrinsicValue: PriceTarget?

    public var displayName: String {
        company.name
    }

    public init(symbol: Symbol, company: Company, price: Decimal, currency: Currency,
                marketCap: UInt64? = nil, exchange: Exchange? = nil, change: Change? = nil) {
        self.symbol = symbol
        self.company = company
        self.price = abs(price)
        self.currency = currency
        self.marketCap = marketCap
        self.exchange = exchange
        self.change = change
    }
}

extension Stock: Hashable {

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
