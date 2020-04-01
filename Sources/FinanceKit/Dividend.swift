//
//  Dividend.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 05/08/2017.
//

import Foundation

public struct Dividend: Hashable, Identifiable, Equatable {
    public let id = UUID()
    public let symbol: Symbol
    public var value: Amount = 0

    public init(symbol: Symbol, value: Amount = 0) {
        self.symbol = symbol
        self.value = value
    }
}
