//
//  Money.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 06/04/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public struct Money {

    private static let decimalHandler = NSDecimalNumberHandler(
        roundingMode: .bankers,
        scale: 2,
        raiseOnExactness: true,
        raiseOnOverflow: true,
        raiseOnUnderflow: true,
        raiseOnDivideByZero: true
    )

    /// - returns: Rounded amount in decimal using NSDecimalNumberHandler
    public var amount: Decimal {
        NSDecimalNumber(decimal: rawValue).rounding(accordingToBehavior: Self.decimalHandler).decimalValue
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

    public init(_ amount: Decimal, in currency: Currency? = nil) {
        self.rawValue = amount
        self.currency = currency
    }

    public init(amount: Double, in currency: Currency? = nil) {
        self.rawValue = Decimal(amount)
        self.currency = currency
    }

    public init?(string: String, in currency: Currency? = nil) {
        guard let doubleValue = Double(string) else { return nil }
        self.rawValue = Decimal(doubleValue)
        self.currency = currency
    }
}

extension Money: ExpressibleByFloatLiteral {

    public typealias FloatLiteralType = Double

    public init(floatLiteral value: Self.FloatLiteralType) {
        self = Self(Decimal(value))
    }
}

extension Money: Equatable {

    public static func == (lhs: Money, rhs: Money) -> Bool {
        lhs.amount == rhs.amount
    }
}

extension Money: Comparable {

    public static func < (lhs: Money, rhs: Money) -> Bool {
        lhs.amount < rhs.amount
    }
}

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
