//
//  NumberFormatter+Currency.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 08/05/2020.
//

import Foundation

extension NumberFormatter {

    public static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }

    public static var monetary: NumberFormatter {
        let formatter = NumberFormatter()
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
        guard let number = number(from: string) else { return nil }
        return Money(number.decimalValue, in: currency)
    }

    public func string(fromMoney money: Money) -> String? {
        string(fromDecimal: money.amount)
    }

    public func string(fromDecimal number: Decimal) -> String? {
        string(from: number.rounded as NSDecimalNumber)
    }
}
