//
//  DateExtensions.swift
//  HabitsRN
//
//  Created by Matthew Hall on 2/27/21.
//
import Foundation

extension Date {
    //formats date into a string format
    var stringValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
    
    //boolean that checks if its a new day
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        let calander = Calendar.current
        return calander.isDateInYesterday(self)
    }
}
