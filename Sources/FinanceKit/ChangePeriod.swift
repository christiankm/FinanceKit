//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

/// Represent a time frame between two dates, or one day if the period is intraday.
public enum ChangePeriod {
    /// A period representing all-time.
    case all
    /// A period of ten years.
    case tenYears
    /// A period of five years.
    case fiveYears
    /// A period of three years.
    case threeYears
    /// A period of two years.
    case twoYears
    /// A period of one year.
    case oneYear
    /// A period representing the current year until the current date.
    case yearToDate
    /// A period of six months.
    case sixMonths
    /// A period of three months.
    case threeMonths
    /// A period of one month.
    case oneMonth
    /// A period of five days.
    case fiveDays
    /// A period representing event within the current day.
    case intraday

    /// Returns the start date of the period in the past from today, or nil if the date can not be computed.
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

extension ChangePeriod: Codable {}
