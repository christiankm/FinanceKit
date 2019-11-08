//
//  Price.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 21/07/2019.
//  Copyright © 2019 Mitteldorf. All rights reserved.
//

import Foundation

public struct Price: RawRepresentable, Hashable, Equatable, Codable {
    public let rawValue: Decimal

    public init(rawValue: Decimal) {
        self.rawValue = rawValue
    }
}
