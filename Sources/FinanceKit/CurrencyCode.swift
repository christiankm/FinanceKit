//
//  CurrencyCode.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 29/11/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
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
        self != .unknown ? rawValue.uppercased() : ""
    }
}
