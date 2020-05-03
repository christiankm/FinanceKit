//
//  CurrencyFormatter.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 20/04/2020.
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

    let locale: Locale
    let currencyCode: String

    private let formatter = NumberFormatter()

    public init(locale: Locale, currencyCode: String) {
        self.locale = locale
        self.currencyCode = currencyCode

        formatter.numberStyle = .currency
        formatter.locale = locale
        formatter.currencyCode = currencyCode
    }

    public func string(from number: Decimal) -> String? {
        formatter.string(from: number.rounded as NSDecimalNumber)
    }
}

public extension NumberFormatter {

    func string(from doubleValue: Double?) -> String? {
        if let doubleValue = doubleValue {
            return string(from: NSNumber(value: doubleValue))
        }
        return nil
    }
}
