//
//  Decimal+DoubleValue.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 07/11/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

extension Decimal {

    /// The double value of the decimal number.
    public var doubleValue: Double {
        (self as NSNumber).doubleValue
    }
}
