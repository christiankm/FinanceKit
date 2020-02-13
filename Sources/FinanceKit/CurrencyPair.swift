//
//  CurrencyPair.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 23/01/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public struct CurrencyPair {

    public let rate: Decimal
    public let baseCurrency: Currency
    public let secondaryCurrency: Currency

    public init(baseCurrency: Currency, secondaryCurrency: Currency, rate: Decimal) {
        precondition(baseCurrency != secondaryCurrency)

        self.baseCurrency = baseCurrency
        self.secondaryCurrency = secondaryCurrency
        self.rate = rate
    }
}
