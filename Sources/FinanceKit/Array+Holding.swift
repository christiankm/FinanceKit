//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

extension Array where Element == Holding {

    /// Returns all currently open holdings in the array.
    public var active: [Holding] {
        filter(\.isActive)
    }

    /// Searches the array for a match for this symbol, and returns
    /// the first item that matches, or nil if there are no holdings of this symbol.
    /// - Parameter symbol: A symbol to match.
    /// - Returns: The first holding with this symbol or nil if no matches.
    public func contains(symbol: Symbol) -> Holding? {
        first { $0.symbol == symbol }
    }
}
