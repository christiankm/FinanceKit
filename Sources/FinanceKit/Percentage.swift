//
//  Percentage.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 20/04/2020.
//

import Foundation

public struct Percentage: RawRepresentable, Equatable, Hashable, Codable {

    public let rawValue: Double

    public var formattedString: String? {
        PercentageFormatter().string(from: self)
    }

    public var basisPoints: Int {
        Int(rawValue * 100)
    }

    public init(_ rawValue: Double) {
        self.init(rawValue: rawValue)
    }

    public init(rawValue: Double) {
        self.rawValue = rawValue
    }
}

extension Percentage: Comparable {

    public static func < (lhs: Percentage, rhs: Percentage) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
