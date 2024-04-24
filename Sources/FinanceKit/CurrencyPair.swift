//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct CurrencyPair: Equatable, Hashable, Codable {

    public let baseCurrency: Currency
    public let secondaryCurrency: Currency
    public let rate: ExchangeRate

    public init(baseCurrency: Currency, secondaryCurrency: Currency, rate: ExchangeRate) {
        self.baseCurrency = baseCurrency
        self.secondaryCurrency = secondaryCurrency
        self.rate = rate
    }
}
