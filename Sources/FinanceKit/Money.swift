//
//  Money.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 06/04/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

/// An amount of money in a given currency.
public struct Money: Hashable {

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
    public var formattedString: String? {
        if let currency = self.currency {
            let formatter = CurrencyFormatter(currency: currency, locale: .current)
            return formatter.string(from: self)
        } else {
            return NumberFormatter.monetary.string(from: amount as NSDecimalNumber)
        }
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

    /// Converts and returns a new `Money` in the given currency with a new amount.
    /// - Parameter to: The currency the money should be in.
    /// - Parameter at: The conversion rate to use.
    /// - Returns: A new `Money` with the converted amount in the given currency.
    /// If the current currency is nil, no conversion is made, and the new Money will have the same amount.
    public func convert(to targetCurrency: Currency, at rate: ExchangeRate) -> Self {
        guard self.currency != nil else {
            return Self(rawValue, in: currency)
        }

        let converter = CurrencyConverter()
        let convertedAmount = converter.convert(self, to: targetCurrency, at: rate)

        return Money(convertedAmount.amount, in: targetCurrency)
    }
}

// MARK: - ComparableToZero

extension Money: ComparableToZero {

    /// - returns: True if the amount is exactly zero.
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
        if let singleValueContainer = try? decoder.singleValueContainer() {
            var amount: Double?
            if let double = try? singleValueContainer.decode(Double.self) {
                amount = double
            }

            if let amount = amount {
                self.rawValue = Decimal(amount)
                self.currency = .none
            } else {
                throw DecodingError.dataCorruptedError(in: singleValueContainer, debugDescription: "Could not decode value for amount")
            }
        } else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode Money value")
            throw DecodingError.dataCorrupted(context)
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
    public func `in`(_ currency: Currency) -> Money {
        Money(self, in: currency)
    }
}

// MARK: - Sum and Average

public extension Collection where Element == Money {

    /// Returns the sum of the money in the collection.
    /// All elements must have the same currency (or none), otherwise this returns nil.
    var sum: Money? {
        let uniqueElements = Set(self.map(\.currency))
        guard uniqueElements.count == 1 else { return nil }
        return reduce(0, +)
    }

    /// Returns the average of the money in the collection, or zero if the collection is empty
    /// All elements must have the same currency (or none), otherwise this returns nil.
    var average: Money? {
        guard !isEmpty else { return Money(0) }

        let uniqueElements = Set(self.map(\.currency))
        guard uniqueElements.count == 1,
              let sum = sum else { return nil }

        return sum / Money(Decimal(count))
    }
}
