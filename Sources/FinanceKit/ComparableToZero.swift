//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

/// Conforming to this protocol requires the conformer to provide methods comparing a numeric value against zero.
/// The protocol provides methods to check if a number is zero, positive, negative or greater than zero.
public protocol ComparableToZero {

    /// - returns: True if the amount is exactly zero.
    var isZero: Bool { get }

    /// - returns: True if the rounded amount is positive, i.e. zero or more.
    var isPositive: Bool { get }

    /// - returns: True if the rounded amount is less than zero, or false if the amount is zero or more.
    var isNegative: Bool { get }

    /// - returns: True if the rounded amount is greater than zero, or false if the amount is zero or less.
    var isGreaterThanZero: Bool { get }
}

extension Int: ComparableToZero {

    /// - returns: True if the amount is exactly zero.
    public var isZero: Bool {
        self == 0
    }

    /// - returns: True if the rounded amount is positive, i.e. zero or more.
    public var isPositive: Bool {
        isZero || isGreaterThanZero
    }

    /// - returns: True if the rounded amount is less than zero, or false if the amount is zero or more.
    public var isNegative: Bool {
        self < Self(0)
    }

    /// - returns: True if the rounded amount is greater than zero, or false if the amount is zero or less.
    public var isGreaterThanZero: Bool {
        self > Self(0)
    }
}

extension Decimal: ComparableToZero {

    /// - returns: True if the amount is exactly zero.
    public var isZero: Bool {
        self == 0
    }

    /// - returns: True if the rounded amount is positive, i.e. zero or more.
    public var isPositive: Bool {
        isZero || isGreaterThanZero
    }

    /// - returns: True if the rounded amount is less than zero, or false if the amount is zero or more.
    public var isNegative: Bool {
        self < Self(0)
    }

    /// - returns: True if the rounded amount is greater than zero, or false if the amount is zero or less.
    public var isGreaterThanZero: Bool {
        self > Self(0)
    }
}

extension FloatingPoint {

    /// - returns: True if the amount is exactly zero.
    public var isZero: Bool {
        self == Self(0)
    }

    /// - returns: True if the rounded amount is positive, i.e. zero or more.
    public var isPositive: Bool {
        isZero || isGreaterThanZero
    }

    /// - returns: True if the rounded amount is less than zero, or false if the amount is zero or more.
    public var isNegative: Bool {
        self < Self(0)
    }

    /// - returns: True if the rounded amount is greater than zero, or false if the amount is zero or less.
    public var isGreaterThanZero: Bool {
        self > Self(0)
    }
}
