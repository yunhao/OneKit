//
//  File.swift
//  
//
//  Created by yunhao on 2020/10/21.
//

import Foundation

public extension DateFormatter {
    
    struct Option {
        /// A closure used to apply option to the formatter.
        let assign: (DateFormatter) -> Void
        
        private init(assign: @escaping (DateFormatter) -> Void) {
            self.assign = assign
        }
        
        public static func calendar(_ calendar: Calendar) -> Option {
            return Option { $0.calendar = calendar }
        }
        
        public static func locale(_ locale: Locale) -> Option {
            return Option { $0.locale = locale }
        }
        
        public static func dateStyle(_ style: DateFormatter.Style) -> Option {
            return Option { $0.dateStyle = style }
        }
        
        public static func timeStyle(_ style: DateFormatter.Style) -> Option {
            return Option { $0.timeStyle = style }
        }
        
        public static func dateFormat(_ format: String) -> Option {
            return Option { $0.dateFormat = format }
        }
        
        public static func dateFormatTemplate(_ formatTemplate: String) -> Option {
            return Option { $0.setLocalizedDateFormatFromTemplate(formatTemplate) }
        }
        
        public static func doesRelativeDateFormatting(_ relative: Bool) -> Option {
            return Option { $0.doesRelativeDateFormatting = relative }
        }
        
        public static func custom(_ closure: @escaping (DateFormatter) -> Void) -> Option {
            return Option(assign: closure)
        }
    }
}

extension DateFormatter {
    /// Apply options to the formatter.
    func apply(options: [Option]) {
        options.forEach { $0.assign(self) }
    }
}
