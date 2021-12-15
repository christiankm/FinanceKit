//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
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

    /// Returns the number rounded to two decimals.
    /// Using this help prevent incorrect values especially during serialization.
    public var rounded: Self {
        NSDecimalNumber(decimal: self).rounding(accordingToBehavior: Self.decimalHandler).decimalValue
    }
}
