//
//  Quantity.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 08/11/2019.
//

import Foundation

public struct Quantity: RawRepresentable, Hashable, Codable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
