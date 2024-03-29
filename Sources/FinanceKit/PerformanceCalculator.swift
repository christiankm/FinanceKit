//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct PerformanceCalculator {

    public init() {}

    public func totalChange(
        from startDate: Date,
        with transactions: [Transaction],
        historicalPrices: [Symbol: [HistoricalPrice]]
    ) -> Change {
        totalChange(between: startDate, and: Date(), with: transactions, historicalPrices: historicalPrices)
    }

    // TODO: Change must also factor in dividends received, and commission paid on the cost-basis. Not just the price at that point.
    public func totalChange(
        between startDate: Date,
        and endDate: Date,
        with transactions: [Transaction],
        historicalPrices: [Symbol: [HistoricalPrice]]
    ) -> Change {
        let holdings = holdingsInPeriod(with: transactions, from: startDate, to: endDate)

        var totalHistoricalPrice: Price = 0.0
        var totalCurrentPrice: Price = 0.0

        holdings.forEach { holding in
            guard let holdingHistoricalData = historicalPrices[holding.symbol] else {
                return
            }
            let historicalDataInPeriod = holdingHistoricalData
                .filter { data in
                    data.date.isAfterOrSameAs(startDate) && data.date.isBeforeOrSameAs(endDate)
                }
                .sorted { $0.date < $1.date }

            totalHistoricalPrice += historicalDataInPeriod.first?.price ?? 0
            totalCurrentPrice += historicalDataInPeriod.last?.price ?? 0
        }

        return Change(cost: totalHistoricalPrice, currentValue: totalCurrentPrice)
    }

    internal func holdingsInPeriod(with transactions: [Transaction], from startDate: Date, to endDate: Date) -> [Holding] {
        let transactionsInPeriod = transactions.filter { $0.date.isAfterOrSameAs(startDate) && $0.date.isBeforeOrSameAs(endDate) }
        return Holding.makeHoldings(with: transactionsInPeriod)
    }
}
