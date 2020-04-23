//
//  Decimal+Rounded.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 20/04/2020.
//

import Foundation

extension Decimal {

    private static let decimalHandler = NSDecimalNumberHandler(
        roundingMode: .bankers,
        scale: 2,
        raiseOnExactness: true,
        raiseOnOverflow: true,
        raiseOnUnderflow: true,
        raiseOnDivideByZero: true
    )

    public var rounded: Self {
        NSDecimalNumber(decimal: self).rounding(accordingToBehavior: Self.decimalHandler).decimalValue
    }
}
