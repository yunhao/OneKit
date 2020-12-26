//
//  RelativeDateTimeFormatter+Extensions.swift
//  
//
//  Created by yunhao on 2020/9/28.
//

import Foundation

@available(iOS 13.0, *)
public extension RelativeDateTimeFormatter {
    
    // MARK: - Option
    /// [DateCommponentsFormatter]:
    /// https://developer.apple.com/documentation/foundation/relativedatetimeformatter
    ///
    /// This struct is a syntactic sugar used to configure [DateCommponentsFormatter], for more information, read the documentation
    /// of [DateCommponentsFormatter].
    struct Option {
        /// A closure used to apply option to the formatter.
        let assign: (RelativeDateTimeFormatter) -> Void
        
        private init(assign: @escaping (RelativeDateTimeFormatter) -> Void) {
            self.assign = assign
        }
        
        public static func calendar(_ calendar: Calendar) -> Option {
            return Option { $0.calendar = calendar }
        }
        
        public static func locale(_ locale: Locale) -> Option {
            return Option { $0.locale = locale }
        }
        
        public static func unitsStyle(_ style: RelativeDateTimeFormatter.UnitsStyle) -> Option {
            return Option { $0.unitsStyle = style }
        }
        
        public static func dateTimeStyle(_ style: RelativeDateTimeFormatter.DateTimeStyle) -> Option {
            return Option { $0.dateTimeStyle = style }
        }
        
        public static func custom(_ closure: @escaping (RelativeDateTimeFormatter) -> Void) -> Option {
            return Option(assign: closure)
        }
    }
}

@available(iOS 13.0, *)
extension RelativeDateTimeFormatter {
    /// Apply options to the formatter.
    func apply(options: [Option]) {
        options.forEach { $0.assign(self) }
    }
}
