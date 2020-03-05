//
//  Change.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 05/08/2017.
//  Copyright © 2019 Mitteldorf. All rights reserved.
//

import Foundation

/// A Change keeps track of the numerical and percent changes between the cost and current price.
public struct Change: Codable, Equatable, Hashable {

    public let amountValue: Decimal
    // TODO: Should return a percentage as times, 100% = 1.0, -50 = -0.5, 300% = 3 -- cap with property wrapper
    public let percentageValue: Double

    public var isPositive: Bool {
        amountValue >= 0
    }

    public var isNegative: Bool {
        amountValue.isLess(than: 0)
    }

    @available(*, deprecated, message: "Text formatting will be removed in a future version")
    public var percentageText: String {
        "\(percentageValue) %"
    }

    public static let zero: Change = Change(cost: 0, currentValue: 0)

    // TODO: Should allow a percentage factor as times, 100% = 1.0, -50 = -0.5, 300% = 3 -- cap with property wrapper
    public init(percentageValue: Double) {
        self.amountValue = percentageValue >= 0 ? 1 : -1
        self.percentageValue = percentageValue
    }

    public init(cost: Decimal, currentValue: Decimal) {
        if cost == 0, currentValue == 0 {
            self.amountValue = 0
            self.percentageValue = 0
            return
        }

        self.amountValue = (currentValue - cost)

        if amountValue >= 0 {
            self.percentageValue = ((amountValue / cost) * 100).doubleValue
        } else {
            self.percentageValue = (((cost - currentValue) / cost) * 100 * -1).doubleValue
        }
    }
}
