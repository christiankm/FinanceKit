//
//  Exchange.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 10/01/2020.
//  Copyright © 2017 Christian Mitteldorf. All rights reserved.
//

import Foundation

public struct Exchange: Codable, Equatable {
    
    public let symbol: String
    public let name: String

    public init(symbol: String, name: String) {
        self.symbol = symbol
        self.name = name
    }
}
