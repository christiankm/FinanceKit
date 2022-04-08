//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

/// `CurrencyFormatter` lets you format a number of monetary amounts with a currency symbol or code.
public struct CurrencyFormatter {

    /// The users locale.
    public let locale: Locale

    /// The currency to use when formatting.
    public let currency: Currency

    private let formatter = NumberFormatter.currency

    /// Initialize a new formatter with a specified currency and locale.
    /// Locale is an optional parameter and defaults to `.autoupdatingCurrent`.
    public init(currency: Currency, locale: Locale = .autoupdatingCurrent) {
        self.currency = currency
        self.locale = locale

        formatter.locale = locale
        formatter.currencyCode = currency.code.rawValue

        if currency.code == .none {
            formatter.numberStyle = .decimal
        }
    }

    /// Returns the decimal value from a formatted string, or nil if parsing fails.
    public func decimal(from string: String) -> Decimal? {
        guard let number = formatter.number(from: string) else {
            return nil
        }
        return number.decimalValue
    }

    /// Returns the `Money` value from a formatted string, or nil if parsing fails.
    public func money(from string: String) -> Money? {
        guard let number = formatter.number(from: string) else {
            return nil
        }
        return Money(number.decimalValue, in: currency)
    }

    /// Returns a formatted string from a number, or nil if formatting fails.
    public func string(from number: Decimal) -> String? {
        formatter.string(from: number.rounded.asDecimalNumber)
    }

    /// Returns a formatted string from a `Money`-value, or nil if formatting fails.
    public func string(from money: Money) -> String? {
        formatter.string(from: money.amount.asDecimalNumber)
    }
}
