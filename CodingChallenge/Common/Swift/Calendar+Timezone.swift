//
//  File.swift
//  File
//
//  Created by lyzkov on 29/07/2021.
//

import Foundation

public extension Calendar {
    
    static let gregorian: Self = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        return calendar
    }()
    
    static let gregorianGMT0: Self = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    static let gregorianCDT: Self = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: "CDT")!
        return calendar
    }()
    
}

public extension Date {
    
    func startOfWeek(using calendar: Calendar = .gregorian) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    func nextWeek(using calendar: Calendar = .gregorian) -> Date {
        calendar.date(byAdding: .day, value: 7, to: self)!
    }
    
    static func currentStartOfWeekInDallas() -> Date {
        // FIXME: Should be GMT0 but ShiftKey API expects from start
        // parameter to be a date converted to address' timezone
        Date().startOfWeek(using: .gregorianCDT)
    }
    
}
