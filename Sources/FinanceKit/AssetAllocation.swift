//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct AssetAllocation {
    public let name: String
    public let allocation: Percentage
    public let returnRate: Percentage

    public init(name: String, allocation: Percentage, returnRate: Percentage) {
        self.name = name
        self.allocation = allocation
        self.returnRate = returnRate
    }
}

extension AssetAllocation: Codable, Hashable {}

extension Array where Element == AssetAllocation {

    public var averageReturnRate: Percentage {
        var returnRate = 0.0
        forEach { asset in
            returnRate += (asset.allocation.decimal * asset.returnRate.decimal)
        }

        return Percentage(decimal: returnRate)
    }
}
