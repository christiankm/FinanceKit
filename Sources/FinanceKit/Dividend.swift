//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct Dividend: Identifiable, Equatable, Hashable {
    public let id = UUID()
    public let symbol: Symbol
    public let value: Money
    public let payDate: Date

    public init(symbol: Symbol, payDate: Date, value: Money = 0) {
        self.symbol = symbol
        self.payDate = payDate
        self.value = value
    }
}
