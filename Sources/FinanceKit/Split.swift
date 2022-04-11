//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

/// A split (commonly used for stocks) is used to split the number of shares into more shares.
/// A split can be reverse meaning many shares are merged into one.
///
/// For example, a company can issue a 1-to-4 stock split where each share turn
/// into shares. without affecting the total market value.
public struct Split {

    /// Split ratio defined as one-to-many or fraction-to-one.
    ///
    /// For example, for a 1-to-5 stock split (where 1 share turn into 5 shares)
    /// this value should be 5. For a reverse split of 4-to-1, this value should be 0.25.
    public typealias Ratio = Double

    /// The symbol of the instrument.
    public let symbol: Symbol

    /// The date of the split.
    public let date: Date

    /// The ratio of the split applied. For reverse splits this ratio will be greater than 1.
    public let ratio: Ratio

    /// Returns true of the split is a reverse split.
    public var isReverseSplit: Bool {
        ratio > 1
    }

    /// Initialize a new Split with the split date and ratio.
    /// - Parameters:
    ///   - symbol: The symbol of the instrument.
    ///   - date: The date where the split is effective from.
    ///   - ratio: A positive non-zero number describing the split ratio.
    public init(symbol: Symbol, date: Date, ratio: Ratio) {
        self.symbol = symbol
        self.date = date
        self.ratio = ratio
    }

    /// Initialize a new Split with the split date, a from factor and to factor.
    /// - Parameters:
    ///   - symbol: The symbol of the instrument.
    ///   - date: The date where the split is effective from.
    ///   - fromFactor: The number of shares we are splitting from.
    ///   - toFactor: The number of shares we end up with.
    public init(symbol: Symbol, date: Date, fromFactor: Int, toFactor: Int) {
        self.symbol = symbol
        self.date = date

        if toFactor == 0 {
            self.ratio = 0
        } else {
            self.ratio = Double(fromFactor) / Double(toFactor)
        }
    }
}

extension Split: Comparable {

    public static func < (lhs: Split, rhs: Split) -> Bool {
        lhs.date > rhs.date
    }
}
