//
//  CurrencyCode.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 29/11/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

// TODO: public enum CurrencyCode: String, Equatable, CaseIterable, Codable {
//    case unknown
//    case DKK
//    case USD
//    case EUR
//    case GBP
//    case AUD
//    case NOK
//    case SEK
//
//    public var currencyCodeString: String {
//        self != .unknown ? rawValue.uppercased() : ""
//    }
//}

public struct CurrencyCode: RawRepresentable, Equatable, Hashable, Codable {
    //TODO: add all world currency codes here (get from .commonIsoCurrencyCodes to know they're supported

    public let rawValue: String

    public var currencyCodeString: String {
        rawValue.uppercased()
    }

    public init(rawValue: String) {
        self.rawValue = rawValue.uppercased()
    }
}
