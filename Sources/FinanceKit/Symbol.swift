//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct Symbol: RawRepresentable, Equatable, Hashable, Codable {

    public let rawValue: String

    public init?(_ rawValue: String) {
        guard let symbol = Symbol(rawValue: rawValue) else { return nil }
        self.rawValue = symbol.rawValue
    }

    public init?(rawValue: String) {
        guard !rawValue.isEmpty else { return nil }

        self.rawValue = rawValue.uppercased()
    }
}

extension Symbol: Comparable {

    public static func < (lhs: Symbol, rhs: Symbol) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension Symbol: CustomStringConvertible {

    public var description: String {
        rawValue
    }
}
