//
//  Date+Extensions.swift
//  OneKit
//
//  Created by yunhao on 2020/9/17.
//  Copyright © 2020 yunhao. All rights reserved.
//

import Foundation

// MARK: - Initializers

public extension Date {
    /// Create a new date from date components.
    ///
    ///     let date = Date(year: 2018, month: 5, day: 16) // "May 16, 2018, 3:28 PM"
    ///
    /// - Parameters:
    ///   - year: Year.
    ///   - month: Month.
    ///   - day: Day.
    ///   - hour: Hour. The defautl value is 0.
    ///   - minute: Minute. The defautl value is 0.
    ///   - second: Second. The defautl value is 0.
    ///   - nanosecond: Nanosecond. The defautl value is 0.
    init?(calendar: Calendar? = .current,
          timeZone: TimeZone? = .current,
          era: Int? = nil,
          year: Int? = nil,
          month: Int? = nil,
          day: Int? = nil,
          hour: Int? = nil,
          minute: Int? = nil,
          second: Int? = nil,
          nanosecond: Int? = nil
    ) {
        let current = Date()
        let components = DateComponents(
            calendar: calendar,
            timeZone: timeZone,
            era: era ?? current.era,
            year: year ?? current.year,
            month: month ?? current.month,
            day: day ?? current.day,
            hour: hour ?? current.hour,
            minute: minute ?? current.minute,
            second: second ?? current.second,
            nanosecond: nanosecond ?? current.nanosecond
        )
        
        guard let date = calendar?.date(from: components) else { return nil }
        self = date
    }

}

extension Date {
    /// The current calendar.
    var calendar: Calendar {
        return Calendar.current
    }
}

// MARK: - Component Values

public extension Date {
    /// The era.
    var era: Int {
        return calendar.component(.era, from: self)
    }
    
    /// The week of the year.
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }
    
    /// The week of the month.
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }
    
    /// The year.
    var year: Int {
        return calendar.component(.year, from: self)
    }
    
    /// The month.
    var month: Int {
        return calendar.component(.month, from: self)
    }

    /// The day.
    var day: Int {
        return calendar.component(.day, from: self)
    }

    /// The weekday.
    var weekday: Int {
        return calendar.component(.weekday, from: self)
    }

    /// The hour.
    var hour: Int {
        return calendar.component(.hour, from: self)
    }

    /// The minute.
    var minute: Int {
        return calendar.component(.minute, from: self)
    }

    /// The seconds.
    var second: Int {
        return calendar.component(.second, from: self)
    }

    /// The nanoseconds.
    var nanosecond: Int {
        return calendar.component(.nanosecond, from: self)
    }
}

// MARK: - Manipulate Date

public extension Date {
    /// The current date and time.
    static var current: Date {
        return Date()
    }
    
    /// Yesterday.
    var yesterday: Date? {
        return calendar.date(byAdding: .day, value: -1, to: self)
    }
    
    /// Tomorrow.
    var tomorrow: Date? {
        return calendar.date(byAdding: .day, value: 1, to: self)
    }
    
    /// Returns a new `Date` representing the date calculated by adding an amount of a specific component to a given date.
    ///
    /// - parameter component: A single component to add.
    /// - parameter value: The value of the specified component to add.
    /// - parameter wrappingComponents: If `true`, the component should be incremented and wrap around to zero/one on overflow, and should not cause higher components to be incremented. The default value is `false`.
    /// - returns: A new date, or nil if a date could not be calculated with the given input.
    func advanced(byAdding component: Calendar.Component, value: Int, wrappingComponents: Bool = false) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self, wrappingComponents: wrappingComponents)
    }
}

// MARK: - Check

public extension Date {
    /// Returns a Boolean value indicating whether the given date is within today.
    var isInToday: Bool {
        return calendar.isDateInToday(self)
    }

    /// Returns a boolean value indicating whether the date is in yesterday.
    var isInYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }

    /// Returns a boolean value indicating whether the date is in tomorrow.
    var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }

    /// Returns a boolean value indicating whether the date is in a weekend period.
    var isInWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }

    /// Returns a boolean value indicating whether the date is in the current week.
    var isInCurrentWeek: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }

    /// Returns a boolean value indicating whether the date is in the current month.
    var isInCurrentMonth: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    /// Returns a boolean value indicating whether the date is in the current year.
    var isInCurrentYear: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .year)
    }
}

// MARK: - Date String

public extension Date {
    /// Returns a string representation of the date formatted using the given format style.
    /// - Parameters:
    ///   - dateStyle: The date style of the receiver.
    ///   - timeStyle: The time style of the receiver.
    /// - Returns: A string representation of date formatted using the given format styles.
    func string(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: self)
    }
    
    /// Returns a string representation of the date according to the given format template.
    ///
    /// This function will first generate an appropriate localized date format from the given template string and locale, and then use the localized
    /// format to generate a string representation of the date.
    ///
    ///     // Locale: "en_US"
    ///     date.localizedString(formatTemplate: "yMMMMd") // "MMMM d, y" -> "September 17, 2020"
    ///     // Locale: "en_GB"
    ///     date.localizedString(formatTemplate: "yMMMMd") // "d MMMM y"  -> "17 September 2020"
    ///
    /// - Note:
    /// In the `setLocalizedDateFormatFromTemplate` code comment: Note that the template string is used only to specify
    /// which date format components should be included. Ordering and other text will not be preserved. The parameter is also not
    /// stored, or updated when the locale or other options change, just as with the ‘dateFormat’ property.
    ///
    /// - Parameters:
    ///   - formatTemplate: The date format template used by the receiver.  The default value is "dd/MM/yyyy".
    ///   - locale: The locale for the receiver. The default  value is the current locale.
    /// - Returns: A string representation of date formatted using a localized format string.
    func localizedString(formatTemplate: String = "dd/MM/yyyy", locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.setLocalizedDateFormatFromTemplate(formatTemplate)
        return dateFormatter.string(from: self)
    }
    
    /// Returns a string representation of the date formatted using the given format string.
    ///
    ///     Date().string(format: "yyyy/MM/dd") -> "2020/06/20"
    ///     Date().string(format: "HH:mm") -> "20:05"
    ///
    /// - Parameter format: The date format string used by the receiver.  The default value is "dd/MM/yyyy".
    /// - Returns: A string representation of date formatted using the given format string.
    func string(format: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
 

// MARK: - Quantities String

public extension Date {
    /// Return a user-readable string representation of quantities of time, from the current date to the end date.
    ///
    /// - Parameters:
    ///   - end: The end date of an interval.
    ///   - options: Options for formatting.
    /// - Returns: A string representation.
    func string(quantitiesTo end: Date, options: [DateComponentsFormatter.Option] = []) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.apply(options: options)
        return formatter.string(from: self, to: end)
    }
    
    /// Return a user-readable string representation of quantities of time, from the start date to the current date.
    ///
    /// - Parameters:
    ///   - start: The start date of an interval.
    ///   - options: Options for formatting.
    /// - Returns: A string representation.
    func string(quantitiesFrom start: Date, options: [DateComponentsFormatter.Option] = []) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.apply(options: options)
        return formatter.string(from: start, to: self)
    }
}

// MARK: - Difference Between Dates

public extension Date {
    /// Returns the difference between this date and the given date.
    /// - Parameters:
    ///   - components: Which components to compare.
    ///   - end: The ending date.
    /// - Returns: The result of calculating the difference from this value to end.
    func components(_ components: Set<Calendar.Component>, to end: Date) -> DateComponents {
        return calendar.dateComponents(components, from: self, to: end)
    }
    
    /// Returns the difference between the given date and this date.
    /// - Parameters:
    ///   - components: Which components to compare.
    ///   - start: The starting date.
    /// - Returns: The result of calculating the difference from start to this value.
    func components(_ components: Set<Calendar.Component>, from start: Date) -> DateComponents {
        return calendar.dateComponents(components, from: start, to: self)
    }
}

