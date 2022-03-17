//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct PercentageFormatter {

    private let formatter: NumberFormatter

    public init(positivePrefix: String = "", minimumFractionDigits: Int = 2, maximumFractionDigits: Int = 2) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.positivePrefix = positivePrefix
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        self.formatter = formatter
    }

    public func string(fromPercentDecimal decimal: FloatLiteralType) -> String? {
        string(from: Percentage(decimal: decimal))
    }

    public func string(from percentage: Percentage) -> String? {
        formatter.string(from: NSNumber(value: percentage.decimal))
    }

    public func percentage(from string: String) -> Percentage? {
        guard let number = formatter.number(from: string) else { return nil }
        return Percentage(decimal: number.doubleValue)
    }
}
