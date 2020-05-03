//
//  PerformanceCalculator.swift
//  
//
//  Created by Christian Mitteldorf on 04/03/2020.
//

import Foundation

public struct PerformanceCalculator {

    public init() {}

    public func totalChange(from startDate: Date, with transactions: [Transaction], historicalPrices: [Symbol: [HistoricalPrice]]) -> Change {
        totalChange(between: startDate, and: Date(), with: transactions, historicalPrices: historicalPrices)
    }

    // TODO: Change must also factor in dividends received, and commission paid on the cost-basis. Not just the price at that point.
    public func totalChange(between startDate: Date, and endDate: Date,
                            with transactions: [Transaction], historicalPrices: [Symbol: [HistoricalPrice]]) -> Change {
        let holdings = holdingsInPeriod(with: transactions, from: startDate, to: endDate)

        var totalHistoricalPrice: Price = 0.0
        var totalCurrentPrice: Price = 0.0

        holdings.forEach { holding in
            guard let holdingHistoricalData = historicalPrices[holding.symbol] else { return }
            let historicalDataInPeriod = holdingHistoricalData.filter { $0.date.isLaterThanOrSameAs(startDate) && $0.date.isEarlierThanOrSameAs(endDate) }.sorted { $0.date < $1.date }

            totalHistoricalPrice += historicalDataInPeriod.first?.price ?? 0
            totalCurrentPrice += historicalDataInPeriod.last?.price ?? 0
        }

        return Change(cost: totalHistoricalPrice, currentValue: totalCurrentPrice)
    }

    internal func holdingsInPeriod(with transactions: [Transaction], from startDate: Date, to endDate: Date) -> [Holding] {
        let transactionsInPeriod = transactions.filter { $0.date.isLaterThanOrSameAs(startDate) && $0.date.isEarlierThanOrSameAs(endDate) }
        return Holding.makeHoldings(with: transactionsInPeriod)
    }
}
