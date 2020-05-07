//
//  CurrencyFormatter.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 07/05/2020.
//

import Foundation

extension NumberFormatter {

    public static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }

    public static let currentLocale: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.alwaysShowsDecimalSeparator = true
        formatter.numberStyle = .decimal
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        return formatter
    }()
}

public struct CurrencyFormatter {

    public let locale: Locale
    public let currency: Currency

    private let formatter = NumberFormatter.currency

    public init(currency: Currency, locale: Locale = .current) {
        self.currency = currency
        self.locale = locale

        formatter.locale = locale
        formatter.currencyCode = currency.code.currencyCodeString
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
