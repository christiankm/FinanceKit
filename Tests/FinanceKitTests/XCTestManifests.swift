#if !canImport(ObjectiveC)
import XCTest

extension ChangeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ChangeTests = [
        ("testEquatable", testEquatable),
        ("testInitWithNegativeChange", testInitWithNegativeChange),
        ("testInitWithPercentageValue", testInitWithPercentageValue),
        ("testInitWithPositiveChange", testInitWithPositiveChange),
        ("testIsNegative", testIsNegative),
        ("testIsPositive", testIsPositive),
        ("testPercentageText", testPercentageText),
        ("testZeroChange", testZeroChange),
    ]
}

extension CompanyTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CompanyTests = [
        ("testComparable", testComparable),
        ("testEquatable", testEquatable),
        ("testInit", testInit),
    ]
}

extension CurrencyConverterTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CurrencyConverterTests = [
        ("testConvertAmountFromCurrencyToCurrencyAtOneToOneRate", testConvertAmountFromCurrencyToCurrencyAtOneToOneRate),
        ("testConvertAmountFromCurrencyToCurrencyAtRate", testConvertAmountFromCurrencyToCurrencyAtRate),
        ("testConvertAmountFromCurrencyToCurrencyWithCurrencyPairs", testConvertAmountFromCurrencyToCurrencyWithCurrencyPairs),
        ("testConvertAmountFromCurrencyToCurrencyWithCurrencyPairsIfInverted", testConvertAmountFromCurrencyToCurrencyWithCurrencyPairsIfInverted),
        ("testConvertAmountWithCurrencyPairAtRate", testConvertAmountWithCurrencyPairAtRate),
        ("testConvertMoneyWithCurrencyToCurrencyAtRate", testConvertMoneyWithCurrencyToCurrencyAtRate),
        ("testConvertMoneyWithoutCurrencyToCurrencyAtRate", testConvertMoneyWithoutCurrencyToCurrencyAtRate),
    ]
}

extension CurrencyFormatterTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CurrencyFormatterTests = [
        ("testDecimalFromString", testDecimalFromString),
        ("testMoneyFromString", testMoneyFromString),
        ("testStringFromDecimal", testStringFromDecimal),
        ("testStringFromDecimalWithNoCurrency", testStringFromDecimalWithNoCurrency),
        ("testStringFromMoney", testStringFromMoney),
        ("testStringFromMoneyLocalCurrency", testStringFromMoneyLocalCurrency),
        ("testStringFromMoneyNonLocalCurrency", testStringFromMoneyNonLocalCurrency),
        ("testStringFromMoneyZeroAmount", testStringFromMoneyZeroAmount),
    ]
}

extension CurrencyPairTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CurrencyPairTests = [
        ("testInit", testInit),
        ("testInitWithSameCurrency", testInitWithSameCurrency),
    ]
}

extension CurrencyTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CurrencyTests = [
        ("testCommonISOCurrencyCodes", testCommonISOCurrencyCodes),
        ("testEquatable", testEquatable),
        ("testInitWithCurrencyCode", testInitWithCurrencyCode),
        ("testISOCurrencyCodes", testISOCurrencyCodes),
        ("testLocaleCurrencyCode", testLocaleCurrencyCode),
        ("testLocaleCurrencySymbol", testLocaleCurrencySymbol),
        ("testLocalizedName", testLocalizedName),
        ("testLocalizedStringForCurrencyCode", testLocalizedStringForCurrencyCode),
    ]
}

extension Date_ComparisonTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Date_ComparisonTests = [
        ("testIsAfter", testIsAfter),
        ("testIsAfterOrSameAs", testIsAfterOrSameAs),
        ("testIsBefore", testIsBefore),
        ("testIsBeforeOrSameAs", testIsBeforeOrSameAs),
    ]
}

extension DecimalDoubleValueTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__DecimalDoubleValueTests = [
        ("testDecimalDoubleValue", testDecimalDoubleValue),
    ]
}

extension DividendTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__DividendTests = [
        ("testInitWithSymbol", testInitWithSymbol),
        ("testInitWithSymbolAndValue", testInitWithSymbolAndValue),
    ]
}

extension ExchangeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ExchangeTests = [
        ("testInit", testInit),
    ]
}

extension HoldingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__HoldingTests = [
        ("testAdjustedCostBasis", testAdjustedCostBasis),
        ("testAverageAdjustedCostBasisPerShare", testAverageAdjustedCostBasisPerShare),
        ("testAverageCostPerShare", testAverageCostPerShare),
        ("testChange", testChange),
        ("testChangeInLocalCurrency", testChangeInLocalCurrency),
        ("testComparable", testComparable),
        ("testCostBasis", testCostBasis),
        ("testDisplayNameWhenCompanyIsCompanyName", testDisplayNameWhenCompanyIsCompanyName),
        ("testDisplayNameWhenNoCompanyIsSymbol", testDisplayNameWhenNoCompanyIsSymbol),
        ("testEquatableDifferentObjectsAreNotEqual", testEquatableDifferentObjectsAreNotEqual),
        ("testEquatableEqualObjectsAreEqual", testEquatableEqualObjectsAreEqual),
        ("testHoldingCostBasisIsClampedToZero", testHoldingCostBasisIsClampedToZero),
        ("testHoldingQuantityIsClampedToZero", testHoldingQuantityIsClampedToZero),
        ("testInitWithDefaultValues", testInitWithDefaultValues),
        ("testInitWithValues", testInitWithValues),
        ("testMakeHoldingsPerformance", testMakeHoldingsPerformance),
        ("testMakeHoldingsWithBuyAndSellAndDividendTransactions", testMakeHoldingsWithBuyAndSellAndDividendTransactions),
        ("testMakeHoldingsWithBuyAndSellTransactions", testMakeHoldingsWithBuyAndSellTransactions),
        ("testMakeHoldingsWithBuyAndSellTransactionsInUnsortedOrder", testMakeHoldingsWithBuyAndSellTransactionsInUnsortedOrder),
        ("testMakeHoldingsWithNoTransactions", testMakeHoldingsWithNoTransactions),
        ("testMakeHoldingsWithOnlyBuyTransactions", testMakeHoldingsWithOnlyBuyTransactions),
        ("testMakeHoldingsWithOnlyDividendTransactions", testMakeHoldingsWithOnlyDividendTransactions),
        ("testMakeHoldingsWithOnlySellTransactions", testMakeHoldingsWithOnlySellTransactions),
        ("testOwnership", testOwnership),
        ("testUpdateWithCurrencyPairsToBaseCurrency", testUpdateWithCurrencyPairsToBaseCurrency),
        ("testUpdateWithCurrencyPairsToBaseCurrencyWhenCurrencyIsEqual", testUpdateWithCurrencyPairsToBaseCurrencyWhenCurrencyIsEqual),
        ("testUpdateWithCurrencyPairsToBaseCurrencyWhenHoldingHasNoCompanyCurrency", testUpdateWithCurrencyPairsToBaseCurrencyWhenHoldingHasNoCompanyCurrency),
        ("testUpdateWithStock", testUpdateWithStock),
        ("testUpdateWithStockWithDifferentSymbol", testUpdateWithStockWithDifferentSymbol),
    ]
}

extension MoneyTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__MoneyTests = [
        ("testAddition", testAddition),
        ("testAmount", testAmount),
        ("testCodableInitFromDecoderKeyedContainer", testCodableInitFromDecoderKeyedContainer),
        ("testCodableInitFromDecoderSingleValueContainer", testCodableInitFromDecoderSingleValueContainer),
        ("testCodableInitFromDecoderUnkeyedContainer", testCodableInitFromDecoderUnkeyedContainer),
        ("testCodableInitFromDecoderUsesRoundedValue", testCodableInitFromDecoderUsesRoundedValue),
        ("testComparable", testComparable),
        ("testConvertDecimalToMoneyCurrency", testConvertDecimalToMoneyCurrency),
        ("testConvertToCurrencyAtRate", testConvertToCurrencyAtRate),
        ("testDescription", testDescription),
        ("testDivision", testDivision),
        ("testDivisionbyZeroReturnsNil", testDivisionbyZeroReturnsNil),
        ("testEncodeToEncoder", testEncodeToEncoder),
        ("testEquatable", testEquatable),
        ("testFormattedAmountWithCurrency", testFormattedAmountWithCurrency),
        ("testFormattedAmountWithoutCurrency", testFormattedAmountWithoutCurrency),
        ("testInitWithDecimal", testInitWithDecimal),
        ("testInitWithDouble", testInitWithDouble),
        ("testInitWithInvalidStringReturnsNil", testInitWithInvalidStringReturnsNil),
        ("testInitWithString", testInitWithString),
        ("testIsGreaterThanZero", testIsGreaterThanZero),
        ("testIsNegative", testIsNegative),
        ("testIsPositive", testIsPositive),
        ("testIsZero", testIsZero),
        ("testMultiplication", testMultiplication),
        ("testRoundingWithValueThatHasKnownRoundingIssue", testRoundingWithValueThatHasKnownRoundingIssue),
        ("testSubtracting", testSubtracting),
    ]
}

extension NumberFormatter_CurrencyTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NumberFormatter_CurrencyTests = [
        ("testCurrencyStyleFormatter", testCurrencyStyleFormatter),
        ("testMonetaryStyleFormatter", testMonetaryStyleFormatter),
    ]
}

extension Numerics_Total_AverageTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Numerics_Total_AverageTests = [
        ("testAverageForBinaryFloatingPointCollection", testAverageForBinaryFloatingPointCollection),
        ("testAverageForBinaryIntegerCollection", testAverageForBinaryIntegerCollection),
        ("testAverageForDecimalCollection", testAverageForDecimalCollection),
        ("testAverageForEmptyBinaryFloatingPointCollection", testAverageForEmptyBinaryFloatingPointCollection),
        ("testAverageForEmptyBinaryIntegerCollection", testAverageForEmptyBinaryIntegerCollection),
        ("testAverageForEmptyDecimalCollection", testAverageForEmptyDecimalCollection),
        ("testTotalForNumericCollection", testTotalForNumericCollection),
    ]
}

extension PercentageFormatterTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PercentageFormatterTests = [
        ("testStringFromPercentDouble", testStringFromPercentDouble),
    ]
}

extension PercentageTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PercentageTests = [
        ("testBasisPoints", testBasisPoints),
        ("testComparable", testComparable),
        ("testFormattedString", testFormattedString),
        ("testInitWithRawValue", testInitWithRawValue),
        ("testZero", testZero),
    ]
}

extension PerformanceCalculatorTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PerformanceCalculatorTests = [
        ("testHoldingsInPeriod", testHoldingsInPeriod),
        ("testTotalChangeBetweenDateAndDate", testTotalChangeBetweenDateAndDate),
        ("testTotalChangeFromDate", testTotalChangeFromDate),
    ]
}

extension PortfolioTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PortfolioTests = [
        ("testInit", testInit),
        ("testTotalCostInLocalCurrencyOfHoldings", testTotalCostInLocalCurrencyOfHoldings),
        ("testTotalCostOfHoldings", testTotalCostOfHoldings),
        ("testUpdateWithCurrencyPairsToBaseCurrency", testUpdateWithCurrencyPairsToBaseCurrency),
        ("testUpdateWithStock", testUpdateWithStock),
        ("testUpdateWithStocks", testUpdateWithStocks),
    ]
}

extension PriceTargetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PriceTargetTests = [
        ("testInit", testInit),
    ]
}

extension StockTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__StockTests = [
        ("testEquatable", testEquatable),
    ]
}

extension SymbolTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SymbolTests = [
        ("testComparable", testComparable),
        ("testCustomStringConvertible", testCustomStringConvertible),
        ("testInitWithEmptyStringReturnsNil", testInitWithEmptyStringReturnsNil),
        ("testInitWithValidString", testInitWithValidString),
    ]
}

extension TransactionTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__TransactionTests = [
        ("testInit", testInit),
        ("testTransactionCostBuy", testTransactionCostBuy),
        ("testTransactionCostDividend", testTransactionCostDividend),
        ("testTransactionCostSell", testTransactionCostSell),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ChangeTests.__allTests__ChangeTests),
        testCase(CompanyTests.__allTests__CompanyTests),
        testCase(CurrencyConverterTests.__allTests__CurrencyConverterTests),
        testCase(CurrencyFormatterTests.__allTests__CurrencyFormatterTests),
        testCase(CurrencyPairTests.__allTests__CurrencyPairTests),
        testCase(CurrencyTests.__allTests__CurrencyTests),
        testCase(Date_ComparisonTests.__allTests__Date_ComparisonTests),
        testCase(DecimalDoubleValueTests.__allTests__DecimalDoubleValueTests),
        testCase(DividendTests.__allTests__DividendTests),
        testCase(ExchangeTests.__allTests__ExchangeTests),
        testCase(HoldingTests.__allTests__HoldingTests),
        testCase(MoneyTests.__allTests__MoneyTests),
        testCase(NumberFormatter_CurrencyTests.__allTests__NumberFormatter_CurrencyTests),
        testCase(Numerics_Total_AverageTests.__allTests__Numerics_Total_AverageTests),
        testCase(PercentageFormatterTests.__allTests__PercentageFormatterTests),
        testCase(PercentageTests.__allTests__PercentageTests),
        testCase(PerformanceCalculatorTests.__allTests__PerformanceCalculatorTests),
        testCase(PortfolioTests.__allTests__PortfolioTests),
        testCase(PriceTargetTests.__allTests__PriceTargetTests),
        testCase(StockTests.__allTests__StockTests),
        testCase(SymbolTests.__allTests__SymbolTests),
        testCase(TransactionTests.__allTests__TransactionTests),
    ]
}
#endif
