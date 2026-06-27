//
//  FinanceKit
//  Copyright © 2024 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

extension NumberFormatter {

    public static func standard(locale: Locale = .autoupdatingCurrent) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale
        return formatter
    }

    public static func currency(locale: Locale = .autoupdatingCurrent) -> NumberFormatter {
        let formatter = NumberFormatter.monetary(locale: locale)
        formatter.locale = locale
        formatter.numberStyle = .currency
        return formatter
    }

    public static func monetary(locale: Locale = .autoupdatingCurrent) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.alwaysShowsDecimalSeparator = true
        formatter.numberStyle = .decimal
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        return formatter
    }
}

extension NumberFormatter {

    public func money(from string: String, in currency: Currency) -> Money? {
        guard let number = number(from: string) else {
            return nil
        }
        return Money(number.decimalValue, in: currency)
    }

    public func string(fromMoney money: Money) -> String? {
        string(fromDecimal: money.amount)
    }

    public func string(fromDecimal number: Decimal) -> String? {
        string(from: number.rounded.asDecimalNumber)
    }
}
