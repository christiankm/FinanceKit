//
//  Dividend.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 05/08/2017.
//

import Foundation

public struct Dividend: Identifiable, Equatable {
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
