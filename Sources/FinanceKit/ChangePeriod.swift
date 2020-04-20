//
//  ChangePeriod.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 16/04/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public enum ChangePeriod {
    case all
    case tenYears
    case fiveYears
    case threeYears
    case twoYears
    case oneYear
    case yearToDate
    case sixMonths
    case threeMonths
    case oneMonth
    case fiveDays
    case intraday

    public var date: Date? {
        switch self {
        case .all:
            return nil
        case .tenYears:
            return Date.tenYearsAgo
        case .fiveYears:
            return Date.fiveYearsAgo
        case .threeYears:
            return Date.threeYearsAgo
        case .twoYears:
            return Date.twoYearsAgo
        case .oneYear:
            return Date.oneYearAgo
        case .yearToDate:
            return Date.firstDayOfThisYear
        case .sixMonths:
            return Date.sixMonthsAgo
        case .threeMonths:
            return Date.threeMonthsAgo
        case .oneMonth:
            return Date.oneMonthAgo
        case .fiveDays:
            return Date.oneWeekAgo
        case .intraday:
            return Date()
        }
    }
}
