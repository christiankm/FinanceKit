//
//  Symbol.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 21/07/2019.
//

import Foundation

public struct Symbol: RawRepresentable, Hashable, Codable {
    public let rawValue: String

    public init?(rawValue: String) {
        guard !rawValue.isEmpty else { return nil }
        self.rawValue = rawValue
    }
}
