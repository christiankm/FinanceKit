//
//  FinanceKit
//  Copyright © 2023 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

/// Company.
public struct Company: Codable, Equatable, Hashable {
    public let symbol: Symbol
    public let name: String
    public let currency: Currency

    /// Initializes a new `Company` with a given symbol, name and base currency.
    ///
    /// - Parameters:
    ///   - symbol: The symbol of the companys stock.
    ///   - name: The name of the company. If this is empty the symbol will be used instead.
    ///   - currency: The main currency of the company. This is usually the same as the country where the company is headquartered.
    public init(symbol: Symbol, name: String, currency: Currency) {
        self.symbol = symbol
        self.name = name.isEmpty ? symbol.rawValue : name
        self.currency = currency
    }
}

extension Company: Comparable {

    public static func < (lhs: Company, rhs: Company) -> Bool {
        lhs.name < rhs.name
    }
}

// @propertyWrapper
// public struct NonEmpty {
//    let defaultValue: String
//    private let value: String?
//
//    public var wrappedValue: String {
//        didSet {
//            if let value = value, !value.isEmpty {
//                wrappedValue = value
//            } else {
//                wrappedValue = defaultValue
//            }
//        }
//    }
//
//    init(_ value: String?, defaultValue: String) {
//        if let value = value, !value.isEmpty {
//            self.value = value
//        } else {
//            self.value = defaultValue
//        }
//        self.defaultValue = defaultValue
//    }
// }
