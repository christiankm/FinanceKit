//
//  Currency.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 17/05/2017.
//  Copyright © 2017 Christian Mitteldorf. All rights reserved.
//

import Foundation

public enum CurrencyCode: String, CaseIterable, Codable {
    #warning("get all currencies and sort by name")
    case unknown
    case DKK
    case USD
    case EUR
    case GBP
    case AUD
    case NOK
    case SEK

    public var currencyCodeString: String {
        self.rawValue.uppercased()
    }

    public var currencyName: String {
        switch self {
        default:
            return ""
        }
    }
}

public struct Currency: Codable {

    public let code: CurrencyCode
    public let name: String

    public init(code currencyCode: CurrencyCode) {
        code = currencyCode
        name = currencyCode.currencyName
    }
}
