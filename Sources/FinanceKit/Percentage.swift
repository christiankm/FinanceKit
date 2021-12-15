//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct Percentage: Equatable, Hashable, Codable {

    /// Return a percentage of zero.
    public static let zero = Percentage(decimal: 0)

    // The percentage in decimal.
    public let decimal: Double

    /// Returns a formatted string with 2 decimal places, e.g. "12.37 %".
    ///
    /// For more formatting options use `PercentageFormatter`.
    public var formattedString: String? {
        PercentageFormatter().string(from: self)
    }

    /// The percentage in basis points, corresponding to the percentage decimal times 1000.
    public var basisPoints: Int {
        Int(decimal * 1000)
    }

    /// Initialize with a decimal, e.g. 0.23 or 1.7.
    public init(decimal: FloatLiteralType) {
        self.decimal = decimal
    }

    /// Initialize with a decimal, e.g. 0.23 or 1.7.
    public init(_ decimal: FloatLiteralType) {
        self.decimal = decimal
    }

    /// Initialize with a percentage, e.g. 12% or 175%, without the symbol..
    public init(percentage: FloatLiteralType) {
        self.decimal = percentage / 100
    }

    /// Initialize with a percentage formatted as a string.
    public init?(string: String) {
        guard let percentage = PercentageFormatter().percentage(from: string) else { return nil }
        self = percentage
    }
}

// MARK: - Comparable

extension Percentage: Comparable {

    public static func < (lhs: Percentage, rhs: Percentage) -> Bool {
        lhs.decimal < rhs.decimal
    }
}

// MARK: - Average

extension Collection where Element == Percentage {

    /// Returns the average of all percentages in the collection.
    public var average: Percentage {
        Percentage(map(\.decimal).average)
    }
}
