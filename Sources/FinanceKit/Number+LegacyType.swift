// swiftlint:disable:this file_name
//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

// swiftlint:disable legacy_objc_type
extension Decimal {

    public var asDecimalNumber: NSDecimalNumber {
        self as NSDecimalNumber
    }
}

extension Int {
    public var asNumber: NSNumber {
        self as NSNumber
    }
}

extension Double {
    public var asNumber: NSNumber {
        self as NSNumber
    }
}

// swiftlint:enable legacy_objc_type
