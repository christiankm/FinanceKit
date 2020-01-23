//
//  CurrencyPair.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 23/01/2020.
//

import Foundation

public struct CurrencyPair {

    public let rate: Decimal
    public let baseCurrency: Currency
    public let secondaryCurrency: Currency

    public init(baseCurrency: Currency, secondaryCurrency: Currency, rate: Decimal) {
        precondition(rate > 0)
        precondition(baseCurrency != secondaryCurrency)

        self.baseCurrency = baseCurrency
        self.secondaryCurrency = secondaryCurrency
        self.rate = rate
    }
}
