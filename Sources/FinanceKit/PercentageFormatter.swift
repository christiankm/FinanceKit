//
//  PercentageFormatter.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 20/04/2020.
//

import Foundation

public struct PercentageFormatter {

    private let formatter: NumberFormatter

    public init(positivePrefix: String = "", minimumFractionDigits: Int = 2, maximumFractionDigits: Int = 2) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.positivePrefix = positivePrefix
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        self.formatter = formatter
    }

    public func string(fromPercent double: Double) -> String? {
        string(from: Percentage(double))
    }

    public func string(from percentage: Percentage) -> String? {
        formatter.string(from: NSNumber(value: percentage.rawValue / 100))
    }
}
