//
//  ComparableToZero.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 22/04/2021.
//

import Foundation

protocol ComparableToZero {

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
    var isZero: Bool {
        self == 0
    }

    /// - returns: True if the rounded amount is positive, i.e. zero or more.
    var isPositive: Bool {
        isZero || isGreaterThanZero
    }

    /// - returns: True if the rounded amount is less than zero, or false if the amount is zero or more.
    var isNegative: Bool {
        self < Self(0)
    }

    /// - returns: True if the rounded amount is greater than zero, or false if the amount is zero or less.
    var isGreaterThanZero: Bool {
        self > Self(0)
    }
}

extension Decimal: ComparableToZero {

    /// - returns: True if the amount is exactly zero.
    var isZero: Bool {
        self == 0
    }

    /// - returns: True if the rounded amount is positive, i.e. zero or more.
    var isPositive: Bool {
        isZero || isGreaterThanZero
    }

    /// - returns: True if the rounded amount is less than zero, or false if the amount is zero or more.
    var isNegative: Bool {
        self < Self(0)
    }

    /// - returns: True if the rounded amount is greater than zero, or false if the amount is zero or less.
    var isGreaterThanZero: Bool {
        self > Self(0)
    }
}

extension FloatingPoint {

    /// - returns: True if the amount is exactly zero.
    var isZero: Bool {
        self == Self(0)
    }

    /// - returns: True if the rounded amount is positive, i.e. zero or more.
    var isPositive: Bool {
        isZero || isGreaterThanZero
    }

    /// - returns: True if the rounded amount is less than zero, or false if the amount is zero or more.
    var isNegative: Bool {
        self < Self(0)
    }

    /// - returns: True if the rounded amount is greater than zero, or false if the amount is zero or less.
    var isGreaterThanZero: Bool {
        self > Self(0)
    }
}
