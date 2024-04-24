//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

/// A Change keeps track of the numerical and percent changes between the cost and current price.
public struct Change: Codable, Equatable, Hashable {

    public static let zero = Change(cost: 0, currentValue: 0)

    public let amount: Amount
    public let percentage: Percentage

    public var percentageText: String? {
        percentage.formattedString
    }

    public init(percentageValue: Percentage) {
        self.amount = percentageValue.decimal.isPositive ? 1.0 : -1.0
        self.percentage = percentageValue
    }

    public init(cost: Amount, currentValue: Amount) {
        guard !cost.isZero else {
            self.amount = 0
            self.percentage = .zero
            return
        }

        self.amount = (currentValue - cost)

        if amount.isPositive {
            self.percentage = Percentage((amount / cost).doubleValue)
        } else {
            self.percentage = Percentage((((cost - currentValue) / cost) * -1).doubleValue)
        }
    }

    public init(from: Money, to: Money) {
        self.init(cost: from.amount, currentValue: to.amount)
    }
}

extension Change: ComparableToZero {

    public var isZero: Bool {
        amount.isZero
    }

    public var isPositive: Bool {
        amount.isPositive
    }

    public var isNegative: Bool {
        amount.isNegative
    }

    public var isGreaterThanZero: Bool {
        amount.isGreaterThanZero
    }
}
