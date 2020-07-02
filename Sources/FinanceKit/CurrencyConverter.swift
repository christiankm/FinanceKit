//
//  CurrencyConverter.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 13/05/2020.
//

import Foundation

public struct CurrencyConverter {

    public init() {}

    public func convert(_ amount: Decimal, from fromCurrency: Currency,
                        to toCurrency: Currency, at rate: ExchangeRate) -> Decimal {
        convert(amount, at: rate)
    }

    public func convert(_ amount: Decimal, from fromCurrency: Currency,
                        to toCurrency: Currency, with pairs: [CurrencyPair]) -> Decimal {
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

    public func convert(_ amount: Decimal, with currencyPair: CurrencyPair) -> Decimal {
        convert(amount, at: currencyPair.rate)
    }

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
