//
//  Money.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 06/04/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

/// An amount of money in a given currency.
public struct Money {

    private static let decimalHandler = NSDecimalNumberHandler(
        roundingMode: .bankers,
        scale: 2,
        raiseOnExactness: true,
        raiseOnOverflow: true,
        raiseOnUnderflow: true,
        raiseOnDivideByZero: true
    )

    /// - returns: Rounded amount of money in decimal using NSDecimalNumberHandler
    public var amount: Decimal {
        NSDecimalNumber(decimal: rawValue).rounding(accordingToBehavior: Self.decimalHandler).decimalValue
    }

    /// - returns: Formatted rounded amount with currency symbol.
    /// If `currency` is not set, returns the formatted amound without currency.
    public var formattedAmount: String? {
        if let currency = self.currency {
            let formatter = CurrencyFormatter(currency: currency, locale: .current)
            return formatter.string(from: self)
        } else {
            return NumberFormatter.monetary.string(from: amount as NSDecimalNumber)
        }
    }

    /// - returns: True is the amount is exactly zero.
    public var isZero: Bool {
        amount.isZero
    }

    /// - returns: True if the rounded amount is positive, i.e. zero or more.
    public var isPositive: Bool {
        isZero || isGreaterThanZero
    }

    /// - returns: True if the rounded amount is less than zero, or false if the amount is zero or more.
    public var isNegative: Bool {
        amount < 0.0
    }

    /// - returns: True if the rounded amount is greater than zero, or false if the amount is zero or less.
    public var isGreaterThanZero: Bool {
        amount > 0.0
    }

    public let currency: Currency?

    /// The raw decimal value. Do not use this directly as it can cause rounding issues.
    /// Instead get the amount-value using the `rounded` property.
    private let rawValue: Decimal

    /// Creates an amount of money with a given decimal number, and optional currency.
    /// - Parameters:
    ///   - amount: An amount of money.
    ///   - currency: A currency the money is in, or nil if no particular currency is needed.
    public init(_ amount: Decimal, in currency: Currency? = nil) {
        self.rawValue = amount
        self.currency = currency
    }

    /// Creates an amount of money with a given double number, and optional currency.
    /// - Parameters:
    ///   - amount: An amount of money.
    ///   - currency: A currency the money is in, or nil if no particular currency is needed.
    public init(amount: Double, in currency: Currency? = nil) {
        self.rawValue = Decimal(amount)
        self.currency = currency
    }

    // MARK: - Arithmetic

    /// Creates an amount of money with a given string number, and optional currency, or returns nil if the string is not a valid number.
    /// - Parameters:
    ///   - string: An amount of money from string.
    ///   - currency: A currency the money is in, or nil if no particular currency is needed.
    public init?(string: String, in currency: Currency? = nil) {
        guard let doubleValue = Double(string) else { return nil }
        self.rawValue = Decimal(doubleValue)
        self.currency = currency
    }

    /// Add two money amounts. This function does not take different currencies into account.
    public static func + (lhs: Money, rhs: Money) -> Money {
        Money(lhs.rawValue + rhs.rawValue)
    }

    /// Subtract two money amounts. This function does not take different currencies into account.
    public static func - (lhs: Money, rhs: Money) -> Money {
        Money(lhs.rawValue - rhs.rawValue)
    }

    /// Multiply two money amounts. This function does not take different currencies into account.
    public static func * (lhs: Money, rhs: Money) -> Money {
        Money(lhs.rawValue * rhs.rawValue)
    }

    /// Divide two money amounts. This function does not take different currencies into account.
    public static func / (lhs: Money, rhs: Money) -> Money? {
        guard !rhs.isZero else { return nil }
        return Money(lhs.rawValue / rhs.rawValue)
    }

    // MARK: Currency Conversion

    /// Converts and returns a new `Money` in the given currency. The amount is not converted with any currency rate.
    /// - Parameter currency: The currency the money should be in.
    /// - Returns: A new `Money` with the current amount in the given currency.
    @discardableResult
    public func convert(to currency: Currency) -> Self {
        Money(rawValue, in: currency)
    }
}

// MARK: - CustomStringConvertible

extension Money: CustomStringConvertible {

    public var description: String {
        "\(self.amount)"
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension Money: ExpressibleByIntegerLiteral {

    public init(integerLiteral value: Int) {
        self = Money(Decimal(value))
    }
}

// MARK: - ExpressibleByFloatLiteral

extension Money: ExpressibleByFloatLiteral {

    public typealias FloatLiteralType = Double

    public init(floatLiteral value: Self.FloatLiteralType) {
        self = Self(Decimal(value))
    }
}

// MARK: - Equatable

extension Money: Equatable {

    public static func == (lhs: Money, rhs: Money) -> Bool {
        lhs.amount == rhs.amount
    }
}

// MARK: - Comparable

extension Money: Comparable {

    public static func < (lhs: Money, rhs: Money) -> Bool {
        lhs.amount < rhs.amount
    }
}

// MARK: - Codable

extension Money: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(Decimal.self)
        do {
            self.init(rawValue)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(amount)
    }
}

// MARK: - Convert to Money

extension Decimal {

    /// Convert a decimal number to `Money` in a given currency.
    /// - Parameter currency: A currency the money is in.
    /// - Returns: A new `Money` with the current amount in the given currency.
    func `in`(_ currency: Currency) -> Money {
        Money(self, in: currency)
    }
}
