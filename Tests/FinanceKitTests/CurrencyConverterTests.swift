//
//  CurrencyConverterTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 13/05/2020.
//

import XCTest
import FinanceKit

class CurrencyConverterTests: XCTestCase {

    func testConvertAmountFromCurrencyToCurrencyAtRate() {
        let amount: Decimal = 100
        let sut = CurrencyConverter()
        let converted = sut.convert(amount, from: .danishKroner, to: .australianDollars, at: 0.225)

        XCTAssertEqual(converted, 22.50)
    }

    func testConvertAmountFromCurrencyToCurrencyAtOneToOneRate() {
        let amount: Decimal = 100
        let sut = CurrencyConverter()
        let converted = sut.convert(amount, from: .danishKroner, to: .australianDollars, at: 1.0)

        XCTAssertEqual(converted, 100)
    }

    func testConvertAmountFromCurrencyToCurrencyWithCurrencyPairs() {
        let amount: Decimal = 100
        let pairs = [
            CurrencyPair(baseCurrency: .australianDollars, secondaryCurrency: .danishKroner, rate: 4.5813)
        ]
        let sut = CurrencyConverter()
        let converted = sut.convert(amount, from: .australianDollars, to: .danishKroner, with: pairs)

        XCTAssertEqual(converted, 458.13, accuracy: 0.01)
    }

    func testConvertAmountFromCurrencyToCurrencyWithCurrencyPairsIfInverted() {
        let amount: Decimal = 100
        let pairs = [
            CurrencyPair(baseCurrency: .danishKroner, secondaryCurrency: .australianDollars, rate: 0.2182)
        ]
        let sut = CurrencyConverter()
        let converted = sut.convert(amount, from: .australianDollars, to: .danishKroner, with: pairs)

        XCTAssertEqual(converted, 458.29, accuracy: 0.01)
    }

    func testConvertAmountWithCurrencyPairAtRate() {
        let amount: Decimal = 100
        let pair = CurrencyPair(baseCurrency: .danishKroner, secondaryCurrency: .australianDollars, rate: 0.225)
        let sut = CurrencyConverter()
        let converted = sut.convert(amount, with: pair)

        XCTAssertEqual(converted, 22.50)
    }

    func testConvertMoneyWithCurrencyToCurrencyAtRate() {
        let money = Money(100, in: .danishKroner)
        let sut = CurrencyConverter()
        let converted: Money = sut.convert(money, to: .australianDollars, at: 0.225)

        XCTAssertEqual(converted, 22.50)
        XCTAssertEqual(converted.currency?.code, .australianDollar)
    }

    func testConvertMoneyWithoutCurrencyToCurrencyAtRate() {
        let amount = Money(100)
        let sut = CurrencyConverter()
        let converted: Money = sut.convert(amount, to: .australianDollars, at: 0.225)

        XCTAssertEqual(converted, 100)
        XCTAssertEqual(converted.currency?.code, .australianDollar)
    }
}
