//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct Holding: Identifiable, Hashable, Codable {

    /// A unique identifier that identifies this holding.
    public var id = UUID()

    public let symbol: Symbol

    public internal(set) var stock: Stock?
    public internal(set) var company: Company?

    public internal(set) var quantity: Quantity {
        didSet {
            quantity = max(quantity, 0)
        }
    }

    /// The total cost basis for all transactions.
    /// Dividends and buybacks are not subtracted into this calculation.
    /// It is therefore the plain purchase price divided by the number of shares.
    /// See `adjustedCostBasis` to include dividends.
    /// Commissions are included in this cost.
    public internal(set) var costBasis: Price {
        didSet {
            costBasis = max(costBasis, 0)
        }
    }

    public internal(set) var costBasisInLocalCurrency: Price {
        didSet {
            costBasisInLocalCurrency = max(costBasisInLocalCurrency, 0)
        }
    }

    public var adjustedCostBasis: Price {
        guard isActive else {
            return 0
        }

        return costBasis - accumulatedDividends
    }

    public internal(set) var adjustedCostBasisInLocalCurrency: Price {
        didSet {
            adjustedCostBasisInLocalCurrency = max(adjustedCostBasisInLocalCurrency, 0)
        }
    }

    /// The average purchase price per share.
    public var averageCostPerShare: Price {
        guard isActive else {
            return 0
        }
        return costBasis / Decimal(quantity)
    }

    public var averageAdjustedCostPerShare: Price {
        guard isActive else {
            return 0
        }
        return adjustedCostBasis / Decimal(quantity)
    }

    @available(*, deprecated, renamed: "averageAdjustedCostPerShare")
    public var averageAdjustedCostBasisPerShare: Price {
        averageAdjustedCostPerShare
    }

    public internal(set) var accumulatedDividends: Amount = 0

    public internal(set) var commissionPaid: Price = 0

    public var displayName: String {
        if let name = company?.name, !name.isEmpty {
            return name
        } else {
            return symbol.rawValue
        }
    }

    public internal(set) var transactions: [Transaction] = []

    public internal(set) var currentValue: Price
    public internal(set) var currentValueInLocalCurrency: Price

    public var change: Change {
        Change(cost: costBasis, currentValue: currentValue)
    }

    public var changeInLocalCurrency: Change {
        Change(cost: costBasisInLocalCurrency, currentValue: currentValueInLocalCurrency)
    }

    /// Returns the return of the holding not including dividends, in its base currency.
    public var returnOnInvestment: Percentage {
        change.percentage
    }

    /// Returns the ownership in terms of percentage of the total amount of outstanding shares.
    public var ownership: Percentage {
        guard let outstandingShares = stock?.shares, outstandingShares > 0 else {
            return .zero
        }
        return Percentage(Double(quantity) / Double(outstandingShares))
    }

    internal var isActive: Bool {
        quantity > 0
    }

    public init(
        symbol: Symbol,
        quantity: Quantity = 0,
        costBasis: Price = 0,
        costBasisInLocalCurrency: Price = 0,
        currentValue: Price = 0,
        currentValueInLocalCurrency: Price = 0,
        adjustedCostBasisInLocalCurrency: Price = 0
    ) {
        self.symbol = symbol
        self.quantity = max(quantity, 0)
        self.costBasis = max(costBasis, 0)
        self.costBasisInLocalCurrency = max(costBasisInLocalCurrency, 0)
        self.currentValue = currentValue
        self.currentValueInLocalCurrency = currentValueInLocalCurrency
        self.adjustedCostBasisInLocalCurrency = adjustedCostBasisInLocalCurrency
    }

    public static func makeHoldings(with transactions: [Transaction]) -> [Holding] {
        guard !transactions.isEmpty else {
            return []
        }

        // Sort transactions by date to be sure they are
        // processed in the right historical order.
        let sortedTransactions = transactions.sorted()

        var holdings: [Holding] = []
        sortedTransactions.forEach { transaction in
            let quantity = transaction.quantity
            let price = transaction.price
            let costBasis = abs(transaction.transactionCost)

            // If a holding already exists for this symbol, update quantity and cost basis.
            // Otherwise add a new holding to the array
            if var holding = holdings.contains(symbol: transaction.symbol) {
                holding.commissionPaid += transaction.commission

                switch transaction.type {
                case .buy:
                    holding.quantity += quantity
                    holding.costBasis += costBasis
                case .sell:
                    holding.quantity -= quantity
                    holding.costBasis -= costBasis
                case .dividend:
                    holding.accumulatedDividends += Decimal(transaction.quantity) * price
                }

                holding.transactions.append(transaction)

                // Remove previous and re-add newly calculated holding
                holdings.removeAll { $0.symbol == transaction.symbol }
                holdings.append(holding)
            } else {
                var holding = Holding(symbol: transaction.symbol)
                holding.commissionPaid += transaction.commission

                switch transaction.type {
                case .buy:
                    holding.quantity += quantity
                    holding.costBasis += costBasis
                case .sell:
                    break
                case .dividend:
                    holding.accumulatedDividends = Decimal(quantity) * price
                }

                holding.transactions.append(transaction)

                holdings.append(holding)
            }
        }

        return holdings.active
    }

    /// Updates the holding with the current price of the specified stock.
    /// Also updates the `company` to reflect the stock.
    ///
    /// This function is useful for updating the holding with the result of a query
    /// from a Stock API, without you having to calculate this yourself.
    ///
    /// - Parameter stock: A stock containing the most recent price, and company details.
    ///   The symbol must match the holding.
    /// - Returns: The newly updated holding.
    public func update(with updatedStock: Stock) -> Holding {
        guard updatedStock.symbol == symbol else {
            return self
        }

        var newHolding = Holding(
            symbol: symbol,
            quantity: quantity,
            costBasis: costBasis,
            costBasisInLocalCurrency: costBasisInLocalCurrency,
            currentValue: updatedStock.price * Decimal(quantity),
            currentValueInLocalCurrency: currentValueInLocalCurrency
        )
        newHolding.stock = updatedStock
        newHolding.company = updatedStock.company
        newHolding.accumulatedDividends = accumulatedDividends
        newHolding.transactions = transactions

        return newHolding
    }

    /// Updates the holdings current value and cost basis in local currencies,
    /// using the companys currency as the base currency.
    /// - Parameter currencyPairs: The current rates to convert the currency with.
    /// - Parameter baseCurrency: The local currency to convert any other values into.
    /// - Returns: If the holdings company has a currency, and a matching currency pair,
    /// it returns the converted holding, otherwise it returns a holding where the local values
    /// is equal to the base values.
    public func update(with currencyPairs: [CurrencyPair], to targetCurrency: Currency) -> Holding {
        guard let companyCurrency = company?.currency else {
            return self
        }

        let converter = CurrencyConverter()
        let convertedCurrentValue = converter.convert(currentValue, from: companyCurrency, to: targetCurrency, with: currencyPairs)
        let convertedCostBasis = converter.convert(costBasis, from: companyCurrency, to: targetCurrency, with: currencyPairs)
        let convertedAdjustedCostBasis = converter.convert(
            adjustedCostBasis,
            from: companyCurrency,
            to: targetCurrency,
            with: currencyPairs
        )

        var newHolding = Holding(
            symbol: symbol,
            quantity: quantity,
            costBasis: costBasis,
            costBasisInLocalCurrency: convertedCostBasis,
            currentValue: currentValue,
            currentValueInLocalCurrency: convertedCurrentValue,
            adjustedCostBasisInLocalCurrency: convertedAdjustedCostBasis
        )
        newHolding.stock = stock
        newHolding.company = company
        newHolding.accumulatedDividends = accumulatedDividends
        newHolding.transactions = transactions

        return newHolding
    }

    public mutating func adjustForSplit(_ split: Split) {
        // Only adjust for splits that has happened
        // and has a valid split ratio.
        guard split.date.isBeforeOrSameAs(Date()),
              split.ratio != 0,
              split.ratio != 1 else {
            return
        }

        guard !transactions.isEmpty else { return }

        // For each transaction, adjust for split
        var adjustedTransactions: [Transaction] = []
        for transaction in transactions {
            guard transaction.type != .dividend,
                  split.date.isAfterOrSameAs(transaction.date) else {
                adjustedTransactions.append(transaction)
                continue
            }

            let adjustedQuantity = Quantity((Double(transaction.quantity) * split.ratio).rounded(.down))
            let adjustedPrice = transaction.price / Decimal(split.ratio)

            adjustedTransactions.append(Transaction(
                type: transaction.type,
                symbol: transaction.symbol,
                date: transaction.date,
                price: adjustedPrice,
                quantity: adjustedQuantity,
                commission: transaction.commission
            ))
        }

        var adjustedHolding = Holding.makeHoldings(with: adjustedTransactions)[0]
        adjustedHolding.stock = stock
        adjustedHolding.company = company
        adjustedHolding.currentValue = currentValue
        adjustedHolding.currentValueInLocalCurrency = currentValueInLocalCurrency

        assert(adjustedHolding.transactions.count == transactions.count, "Two arrays must be of equal count")

        self = adjustedHolding
    }

    public mutating func adjustForSplits(_ splits: [Split]) {
        splits
            .sorted()
            .forEach { adjustForSplit($0) }
    }
}

// MARK: Comparable

extension Holding: Comparable {

    public static func < (lhs: Holding, rhs: Holding) -> Bool {
        lhs.displayName < rhs.displayName
    }
}

// MARK: Equatable

extension Holding: Equatable {

    public static func == (lhs: Holding, rhs: Holding) -> Bool {
        lhs.id == rhs.id &&
            lhs.symbol == rhs.symbol &&
            lhs.stock == rhs.stock &&
            lhs.company == rhs.company &&
            lhs.currentValue == rhs.currentValue &&
            lhs.currentValueInLocalCurrency == rhs.currentValueInLocalCurrency &&
            lhs.change == rhs.change &&
            lhs.changeInLocalCurrency == rhs.changeInLocalCurrency &&
            lhs.transactions == rhs.transactions
    }
}
