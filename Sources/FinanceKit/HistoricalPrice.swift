//
//  HistoricalPrice.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 04/03/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public struct HistoricalPrice {
    public let date: Date
    public let price: Price

    public init(date: Date, price: Price) {
        self.date = date
        self.price = price
    }
}
