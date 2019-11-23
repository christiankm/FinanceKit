//
//  Decimal+DoubleValue.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 07/11/2019.
//

import Foundation

extension Decimal {

    public var doubleValue: Double {
        (self as NSNumber).doubleValue
    }
}
