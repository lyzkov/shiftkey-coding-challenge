//
//  Calendar+Timezone.swift
//  CodingChallenge
//
//  Created by lyzkov on 29/07/2021.
//

import Foundation

public extension Calendar {

    static let GMT0: Self = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()

    static let CST: Self = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "CST")!
        return calendar
    }()

}

public extension Date {

    func startOfWeek(using calendar: Calendar = .current) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }

    func nextWeek(using calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: .day, value: 7, to: startOfWeek(using: calendar))!
    }

    static func todayInDallas() -> Date {
        // Should be GMT0 but ShiftKey API expects from start
        // parameter to be a date converted to local timezone
        Calendar.current
            .date(from: Calendar.CST.dateComponents(
                [.calendar, .year, .month, .day, .hour],
                from: Date()
            ))!
    }

}
