//
//  CurrencyCode.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 29/11/2019.
//

import Foundation

public enum CurrencyCode: String, Equatable, CaseIterable, Codable {
    case unknown
    case DKK
    case USD
    case EUR
    case GBP
    case AUD
    case NOK
    case SEK

    public var currencyCodeString: String {
        rawValue.uppercased()
    }
}
