//
//  DateExtention.swift
//  Xpense
//
//  Created by Surjit on 02/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation

struct DateFormats {
    static let displayDateOnly = "EEEE, MMM d, yyyy"
}

extension Date {
    static func nextYear() -> [Date] {
        return Date.next(numberOfDays: 365, from: Date())
    }
    
    static func previousYear()-> [Date]{
        return Date.next(numberOfDays: 365, from: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)
    }
    
    static func next(numberOfDays: Int, from startDate: Date) -> [Date]{
        var dates = [Date]()
        for i in 0..<numberOfDays {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: startDate) {
                dates.append(date)
            }
        }
        return dates
    }
    
    func formatDisplayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.displayDateOnly
        return dateFormatter.string(from: self)
    }
}

// MARK - Observer Notification Init
extension Notification.Name{
    static var dateChanged : Notification.Name{
        return .init("dateChanged")
    }
    
}
