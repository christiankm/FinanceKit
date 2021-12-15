//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

/// A HistoricalPrice represents a price on a certain date, usually in the past.
/// You can easily add many of these to an array to represent the price history of an asset.
public struct HistoricalPrice {

    /// The date the asset had this price.
    public let date: Date
    /// The price on the specified date.
    public let price: Price

    /// Initializes a new HistoricalPrice with a price on the specified date.
    /// - Parameters:
    ///   - date: The date the asset had this price.
    ///   - price: The price on the specified date.
    public init(date: Date, price: Price) {
        self.date = date
        self.price = price
    }
}
