//
//  Date+Ranges.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 20/04/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public extension Date {

    static var firstDayOfThisYear: Date? {
        Date(day: 1, month: 1, year: Calendar.current.component(.year, from: Date()))
    }

    static var yesterday: Date? {
        Calendar.current.date(byAdding: .day, value: -1, to: Date())
    }

    static var oneWeekAgo: Date? {
        Calendar.current.date(byAdding: .day, value: -7, to: Date())
    }

    static var oneMonthAgo: Date? {
        Calendar.current.date(byAdding: .month, value: -1, to: Date())
    }

    static var threeMonthsAgo: Date? {
        Calendar.current.date(byAdding: .month, value: -3, to: Date())
    }

    static var sixMonthsAgo: Date? {
        Calendar.current.date(byAdding: .month, value: -6, to: Date())
    }

    static var oneYearAgo: Date? {
        Calendar.current.date(byAdding: .year, value: -1, to: Date())
    }

    static var twoYearsAgo: Date? {
        Calendar.current.date(byAdding: .year, value: -2, to: Date())
    }

    static var threeYearsAgo: Date? {
        Calendar.current.date(byAdding: .year, value: -3, to: Date())
    }

    static var fiveYearsAgo: Date? {
        Calendar.current.date(byAdding: .year, value: -5, to: Date())
    }

    static var tenYearsAgo: Date? {
        Calendar.current.date(byAdding: .year, value: -10, to: Date())
    }

    init?(day: Int, month: Int, year: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = .current

        guard let date = Calendar.current.date(from: dateComponents) else { return nil }

        self = date
    }
}
