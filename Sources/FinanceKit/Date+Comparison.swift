//
//  Date+Comparison.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 26/04/2020.
//

import Foundation

extension Date {

    /// Compares this date with the specified date and returns true if the specified date is before.
    /// - Parameter date: A date to compare.
    /// - Returns: True if the specified date is before this date, otherwise false.
    public func isBefore(_ date: Date) -> Bool {
        self < date
    }

    /// Compares this date with the specified date and returns true if the specified date is before or the same.
    /// - Parameter date: A date to compare.
    /// - Returns: True if the specified date is before or the same as this date, otherwise false.
    public func isBeforeOrSameAs(_ date: Date) -> Bool {
        self <= date
    }

    /// Compares this date with the specified date and returns true if the specified date is after.
    /// - Parameter date: A date to compare.
    /// - Returns: True if the specified date is after this date, otherwise false.
    public func isAfter(_ date: Date) -> Bool {
        self > date
    }

    /// Compares this date with the specified date and returns true if the specified date is after or the same.
    /// - Parameter date: A date to compare.
    /// - Returns: True if the specified date is after or the same as this date, otherwise false.
    public func isAfterOrSameAs(_ date: Date) -> Bool {
        self >= date
    }
}
