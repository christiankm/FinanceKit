//
//  CurrencyPair.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 23/01/2020.
//

import Foundation

public struct CurrencyPair: Equatable, Hashable, Codable {

    public let baseCurrency: Currency
    public let secondaryCurrency: Currency
    public let rate: Double

    public init(baseCurrency: Currency, secondaryCurrency: Currency, rate: Double) {
        self.baseCurrency = baseCurrency
        self.secondaryCurrency = secondaryCurrency
        self.rate = rate
    }
}
