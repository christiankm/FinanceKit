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
                        to toCurrency: Currency, at rate: Double) -> Decimal {
        amount * Decimal(rate)
    }

    public func convert(_ amount: Decimal, with currencyPair: CurrencyPair) -> Decimal {
        amount * Decimal(currencyPair.rate)
    }

    public func convert(_ money: Money, to toCurrency: Currency, at rate: Double) -> Money {
        guard money.currency != nil else {
            return Money(money.amount, in: toCurrency)
        }

        let convertedAmount = money.amount * Decimal(rate)

        return Money(convertedAmount, in: toCurrency)
    }
}
