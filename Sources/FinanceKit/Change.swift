//
//  Change.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 05/08/2017.
//  Copyright © 2019 Mitteldorf. All rights reserved.
//

import Foundation

/// A Change keeps track of the numerical and percent changes for a stock.
public struct Change {
    public var value: Double

    public var isPositive: Bool {
        value >= 0
    }

    public var isNegative: Bool {
        value.isLess(than: 0)
    }

    public var percentageText: String {
        "\(value) %"
    }

    public init(value: Double) {
        self.value = value
    }
}
