//
//  PriceTarget.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 12/02/2020.
//

import Foundation

public struct PriceTarget: Codable {
    public let price: Price
    public let date: Date

    public init(price: Price, on date: Date) {
        self.price = price
        self.date = date
    }
}
