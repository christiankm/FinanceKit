//
//  PriceTarget.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 12/02/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
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
