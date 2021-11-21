//
//  Currency.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 17/05/2017.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

/// Currency represents the basic attributes of a currency like its currency code.
/// You would normally not need to construct your own currency, but can instead access one using `Currency(code:)`.
public struct Currency: Codable, Hashable {

    public var localizedName: String? {
        locale.localizedString(forCurrencyCode: code.rawValue)
    }

    /// The ISO 4217 currency code identifying the currency, e.g. GBP.
    public let code: CurrencyCode

    public let locale: Locale

    public init(code: CurrencyCode, locale: Locale = .autoupdatingCurrent) {
        self.code = code
        self.locale = Locale.autoupdatingCurrent
    }

    public init?(codeString: String, locale: Locale = .autoupdatingCurrent) {
        guard let currencyCode = CurrencyCode(rawValue: codeString) else { return nil }
        self.code = currencyCode
        self.locale = locale
    }
}

extension Currency: Equatable {

    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        lhs.code == rhs.code
    }
}

/// This extension provides a bridge to system APIs inside a convenient namespace.
extension Currency {

    /// The currency code of the users current locale.
    public static var currencyCode: String? {
        Locale.current.currencyCode
    }

    /// The currency symbol of the users current locale.
    public static var currencySymbol: String? {
        Locale.current.currencySymbol
    }

    /// A list of available currency codes.
    public static var isoCurrencyCodes: [String] {
        Locale.isoCurrencyCodes
    }

    /// A list of common currency codes.
    public static var commonIsoCurrencyCodes: [String] {
        Locale.commonISOCurrencyCodes
    }

    /// Returns a localized string for a specified ISO 4217 currency code.
    public static func localizedString(forCurrencyCode: String) -> String? {
        NSLocale.system.localizedString(forCurrencyCode: forCurrencyCode)
    }
}
