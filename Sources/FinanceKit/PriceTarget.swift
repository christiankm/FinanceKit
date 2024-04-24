//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct PriceTarget: Codable, Equatable {
    public let price: Price
    public let date: Date

    public init(price: Price, on date: Date) {
        self.price = price
        self.date = date
    }
}
