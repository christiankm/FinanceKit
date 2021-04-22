//
//  Date+Ranges.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 20/04/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public extension Date {

    /// The first date of the year according to the current calender, or nil if the date could not be computed.
    static var firstDayOfThisYear: Date? {
        Date(day: 1, month: 1, year: Calendar.current.component(.year, from: Date()))
    }

    /// The date of yesterday according to the current calender, or nil if the date could not be computed.
    static var yesterday: Date? {
        Calendar.current.date(byAdding: .day, value: -1, to: Date())
    }

    /// The date of one week ago according to the current calender, or nil if the date could not be computed.
    static var oneWeekAgo: Date? {
        Calendar.current.date(byAdding: .day, value: -7, to: Date())
    }

    /// The date of one month ago according to the current calender, or nil if the date could not be computed.
    static var oneMonthAgo: Date? {
        Calendar.current.date(byAdding: .month, value: -1, to: Date())
    }

    /// The date of three months ago according to the current calender, or nil if the date could not be computed.
    static var threeMonthsAgo: Date? {
        Calendar.current.date(byAdding: .month, value: -3, to: Date())
    }

    /// The date of six months ago according to the current calender, or nil if the date could not be computed.
    static var sixMonthsAgo: Date? {
        Calendar.current.date(byAdding: .month, value: -6, to: Date())
    }

    /// The date of one year ago according to the current calender, or nil if the date could not be computed.
    static var oneYearAgo: Date? {
        Calendar.current.date(byAdding: .year, value: -1, to: Date())
    }

    /// The date of two years ago according to the current calender, or nil if the date could not be computed.
    static var twoYearsAgo: Date? {
        Calendar.current.date(byAdding: .year, value: -2, to: Date())
    }

    /// The date of three years ago according to the current calender, or nil if the date could not be computed.
    static var threeYearsAgo: Date? {
        Calendar.current.date(byAdding: .year, value: -3, to: Date())
    }

    /// The date of five years ago according to the current calender, or nil if the date could not be computed.
    static var fiveYearsAgo: Date? {
        Calendar.current.date(byAdding: .year, value: -5, to: Date())
    }

    /// The date of ten years ago according to the current calender, or nil if the date could not be computed.
    static var tenYearsAgo: Date? {
        Calendar.current.date(byAdding: .year, value: -10, to: Date())
    }

    /// Initialize a `Date` with a specific day, month and year using the systems current calendar.
    /// returns: A new `Date` with the given components, or nil if the date could not be computed.
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
