//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

extension Decimal {

    /// The double value of the decimal number.
    public var doubleValue: Double {
        (self as NSNumber).doubleValue
    }
}
