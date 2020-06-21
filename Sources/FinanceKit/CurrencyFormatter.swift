//
//  CurrencyFormatter.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 07/05/2020.
//

import Foundation

public struct CurrencyFormatter {

    public let locale: Locale
    public let currency: Currency

    private let formatter = NumberFormatter.currency

    public init(currency: Currency, locale: Locale = .autoupdatingCurrent) {
        self.currency = currency
        self.locale = locale

        self.formatter.locale = locale
        self.formatter.currencyCode = currency.code.rawValue

        if currency.code == .none {
            self.formatter.numberStyle = .decimal
        }
    }

    public func decimal(from string: String) -> Decimal? {
        guard let number = formatter.number(from: string) else { return nil }
        return number.decimalValue
    }

    public func money(from string: String) -> Money? {
        guard let number = formatter.number(from: string) else { return nil }
        return Money(number.decimalValue, in: currency)
    }

    public func string(from number: Decimal) -> String? {
        formatter.string(from: number.rounded as NSDecimalNumber)
    }

    public func string(from money: Money) -> String? {
        formatter.string(from: money.amount as NSDecimalNumber)
    }
}
