//
//  Currency.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 17/05/2017.
//  Copyright © 2017 Christian Mitteldorf. All rights reserved.
//

import Foundation

public struct Currency: Codable {

    public let code: CurrencyCode

    public var name: String {
        Currency.localizedString(forCurrencyCode: code.rawValue) ?? ""
    }

}



/// This extension provides a bridge to system APIs inside a convienent namespace.
extension Currency {

    static var currencyCode: String? {
        NSLocale.current.currencyCode
    }

    static var currencySymbol: String? {
        NSLocale.current.currencySymbol
    }

    static var isoCurrencyCodes: [String] {
        NSLocale.isoCurrencyCodes
    }

    static var commonIsoCurrencyCodes: [String] {
        NSLocale.commonISOCurrencyCodes
    }

    static func localizedString(forCurrencyCode: String) -> String? {
        NSLocale.system.localizedString(forCurrencyCode: forCurrencyCode)
    }
}
