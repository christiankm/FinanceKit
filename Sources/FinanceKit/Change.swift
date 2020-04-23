//
//  Change.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 05/08/2017.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

/// A Change keeps track of the numerical and percent changes between the cost and current price.
public struct Change: Codable, Equatable, Hashable {

    public static let zero = Change(cost: 0, currentValue: 0)

    public let amount: Amount
    public let percentage: Percentage

    public var isPositive: Bool {
        amount >= 0
    }

    public var isNegative: Bool {
        amount.isLess(than: 0)
    }

    public var percentageText: String? {
        percentage.formattedString
    }

    public init(percentageValue: Percentage) {
        self.amount = percentageValue.rawValue >= 0.0 ? 1.0 : -1.0
        self.percentage = percentageValue
    }

    public init(cost: Decimal, currentValue: Decimal) {
        if cost == 0, currentValue == 0 {
            self.amount = 0
            self.percentage = Percentage(0.0)
            return
        }

        self.amount = (currentValue - cost)

        if amount >= 0 {
            self.percentage = Percentage(((amount / cost) * 100).doubleValue)
        } else {
            self.percentage = Percentage((((cost - currentValue) / cost) * 100 * -1).doubleValue)
        }
    }
}
