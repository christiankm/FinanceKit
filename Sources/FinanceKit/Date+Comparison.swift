//
//  Date+Comparison.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 26/04/2020.
//

import Foundation

extension Date {

    public func isEarlierThan(_ date: Date) -> Bool {
        self < date
    }

    public func isEarlierThanOrSameAs(_ date: Date) -> Bool {
        self <= date
    }

    public func isLaterThan(_ date: Date) -> Bool {
        self > date
    }

    public func isLaterThanOrSameAs(_ date: Date) -> Bool {
        self >= date
    }
}
