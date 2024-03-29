//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

/// CurrencyConverter allows you to convert monetary amounts from one currency to another
/// given a selection of currency pairs, or a fixed exchange rate.
public struct CurrencyConverter {

    /// Initializes an instance of `CurrencyConverter`
    public init() {}

    /// <#Description#>
    /// - Parameters:
    ///   - amount: <#amount description#>
    ///   - fromCurrency: <#fromCurrency description#>
    ///   - toCurrency: <#toCurrency description#>
    ///   - rate: <#rate description#>
    /// - Returns: <#description#>
    public func convert(
        _ amount: Decimal,
        from fromCurrency: Currency,
        to toCurrency: Currency,
        at rate: ExchangeRate
    ) -> Decimal {
        convert(amount, at: rate)
    }

    /// <#Description#>
    /// - Parameters:
    ///   - amount: <#amount description#>
    ///   - fromCurrency: <#fromCurrency description#>
    ///   - toCurrency: <#toCurrency description#>
    ///   - pairs: <#pairs description#>
    /// - Returns: <#description#>
    public func convert(
        _ amount: Decimal,
        from fromCurrency: Currency,
        to toCurrency: Currency,
        with pairs: [CurrencyPair]
    ) -> Decimal {
        guard fromCurrency != toCurrency else {
            return amount
        }

        let currencyPair = pairs.first { $0.baseCurrency == fromCurrency && $0.secondaryCurrency == toCurrency }
        let invertedPair = pairs.first { $0.baseCurrency == toCurrency && $0.secondaryCurrency == fromCurrency }

        if let pair = currencyPair {
            return convert(amount, at: pair.rate)
        } else if let invertedPair = invertedPair {
            return convert(amount, at: 1 / invertedPair.rate)
        }

        return amount
    }

    /// Converts a `Decimal` amount with the rate of the given currency pair.
    ///
    /// - Parameters:
    ///   - amount: An amount to convert from.
    ///   - currencyPair: A `CurrencyPair` to convert the amount with.
    /// - Returns: The converted amount in the target currency.
    public func convert(_ amount: Decimal, with currencyPair: CurrencyPair) -> Decimal {
        convert(amount, at: currencyPair.rate)
    }

    /// <#Description#>
    /// - Parameters:
    ///   - money: <#money description#>
    ///   - toCurrency: <#toCurrency description#>
    ///   - rate: <#rate description#>
    /// - Returns: <#description#>
    public func convert(_ money: Money, to toCurrency: Currency, at rate: ExchangeRate) -> Money {
        guard money.currency != nil else {
            return Money(money.amount, in: toCurrency)
        }

        let convertedAmount = convert(money.amount, at: rate)

        return Money(convertedAmount, in: toCurrency)
    }

    private func convert(_ amount: Decimal, at rate: ExchangeRate) -> Decimal {
        guard rate != 1.0 else {
            return amount
        }

        return amount * Decimal(rate)
    }
}
