//swiftlint:disable:this file_name
//
//  Numerics+Total+Average.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 11/02/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public extension Collection where Element: Numeric {

    /// Returns the total sum of all elements in the array
    var total: Element { reduce(0, +) }
}

public extension Collection where Element: BinaryInteger {

    /// Returns the average of all elements in the array
    var average: Double { isEmpty ? 0 : Double(total) / Double(count) }
}

public extension Collection where Element: BinaryFloatingPoint {

    /// Returns the average of all elements in the array
    var average: Element { isEmpty ? 0 : total / Element(count) }
}

public extension Collection where Element == Decimal {
    var average: Decimal { isEmpty ? 0 : total / Decimal(count) }
}
