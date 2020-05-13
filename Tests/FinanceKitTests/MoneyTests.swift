//
//  MoneyTests.swift
//  FinanceKitTests
//
//  Created by Christian Mitteldorf on 06/04/2020.
//

import XCTest
@testable import FinanceKit

class MoneyTests: XCTestCase {

    // MARK: - Initialization

    func testInitWithDecimal() {
        XCTAssertEqual(Money(12.80).amount, 12.80)
    }

    func testInitWithDouble() {
        XCTAssertEqual(Money(amount: 12.80), Money(12.80))
    }

    func testInitWithString() {
        XCTAssertEqual(Money(string: "22.44"), Money(22.44))
    }

    func testInitWithInvalidStringReturnsNil() {
        XCTAssertNil(Money(string: "-.22,44,00"))
    }

    // MARK: - Properties

    func testAmount() {
        XCTAssertEqual(Money(12.801123).amount, 12.80)
        XCTAssertEqual(Money(0.051).amount, 0.05)
        XCTAssertEqual(Money(4.9923).amount, Money(4.99).amount)
        XCTAssertEqual(Money(25.1239).amount, 25.12)
        XCTAssertEqual(Money(50.555111).amount, 50.56)
        XCTAssertEqual(Money(1299.0000032).amount, 1299.00)
        XCTAssertEqual(Money(0.56).amount.doubleValue, Double(0.56), accuracy: 0.01)
    }

    func testFormattedAmountWithCurrency() {
        let sut = Money(2500.32, in: .usDollars)

        XCTAssertEqual(sut.formattedString!, "$2,500.32")
    }

    func testFormattedAmountWithoutCurrency() {
        let sut = Money(2500.32)

        XCTAssertEqual(sut.formattedString!, "2,500.32")
    }

    func testIsZero() {
        XCTAssertTrue(Money(0.00).isZero)
        XCTAssertFalse(Money(0.56).isZero)
        XCTAssertFalse(Money(-0.56).isZero)
    }

    func testIsPositive() {
        XCTAssertTrue(Money(0.56).isPositive)
        XCTAssertTrue(Money(0.00).isPositive)
        XCTAssertFalse(Money(-0.56).isPositive)
    }

    func testIsNegative() {
        XCTAssertTrue(Money(-0.56).isNegative)
        XCTAssertFalse(Money(0.00).isNegative)
        XCTAssertFalse(Money(0.56).isNegative)
    }

    func testIsGreaterThanZero() {
        XCTAssertTrue(Money(0.56).isGreaterThanZero)
        XCTAssertFalse(Money(0.00).isGreaterThanZero)
        XCTAssertFalse(Money(-0.56).isGreaterThanZero)
    }

    func testDescription() {
        let sut = Money(12.22, in: .danishKroner)

        XCTAssertEqual(sut.description, "12.22")
    }

    // MARK: - Conversion

    func testConvertToCurrencyAtRate() {
        let money = Money(100.0, in: .danishKroner)
        let sut = money.convert(to: .usDollars, at: 0.145)

        XCTAssertEqual(sut.amount, 14.50)
        XCTAssertEqual(sut.currency?.code, .unitedStatesDollar)
    }

    func testConvertDecimalToMoneyCurrency() {
        let amount = Decimal(12.44)
        let sut = amount.in(.usDollars)

        XCTAssertEqual(sut.amount, 12.44)
        XCTAssertEqual(sut.currency, .usDollars)
    }

    // MARK: - Arithmetic

    func testAddition() {
        let added = Money(4.00) + Money(5.40)
        XCTAssertEqual(added, Money(9.40))
    }

    func testSubtracting() {
        let subtracted = Money(8.00) - Money(5.40)
        XCTAssertEqual(subtracted, Money(2.60))
    }

    func testMultiplication() {
        let multiplied = Money(4.00) * Money(5.40)
        XCTAssertEqual(multiplied, Money(21.60))
    }

    func testDivision() {
        let divided = Money(4.00) / Money(5.40)
        XCTAssertEqual(divided, Money(0.7404))
    }

    func testDivisionbyZeroReturnsNil() {
        let divided = Money(4.00) / Money(0)
        XCTAssertNil(divided)
    }

    func testEquatable() {
        XCTAssertEqual(Money(12.33), Money(12.33))
    }

    func testComparable() {
        XCTAssertGreaterThan(Money(12.50), Money(12.22))
    }

    // Verifies that numbers are correctly rounded and formatted when the
    // number has known rounding issues, leaving precision decimals.
    // For example "0.56 could sometimes show up as "0.5600000000000001024".
    func testRoundingWithValueThatHasKnownRoundingIssue() {
        let sut = Money(0.56)
        XCTAssertEqual(sut.amount.doubleValue, Double(0.56), accuracy: 0.01)
    }

    // MARK: - Codable

    func testInitFromDecoderSingleValue() {
        let json = Data("0.56".utf8)
        let sut = try! JSONDecoder().decode(Money.self, from: json)

        XCTAssertEqual(sut, Money(0.56))
    }

    func testEncodeToEncoder() {
        let sut = Money(0.56)
        let data = try! JSONEncoder().encode(sut)
        let json = String(decoding: data, as: UTF8.self)

        XCTAssertNotEqual(json, "0.5600000000000001024")
        XCTAssertEqual(json, "0.56")
    }
}

