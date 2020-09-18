//
//  DateComponentsFormatter+Extensions.swift
//  OneKit
//
//  Created by yunhao on 2020/9/17.
//  Copyright © 2020 yunhao. All rights reserved.
//

import Foundation

public extension DateComponentsFormatter {
    
    // MARK: - Option
    /// [DateCommponentsFormatter]:
    /// https://developer.apple.com/documentation/foundation/datecomponentsformatter
    ///
    /// This struct is a syntactic sugar used to configure [DateCommponentsFormatter], for more information, read the documentation
    /// of [DateCommponentsFormatter].
    struct Option {
        /// A closure used to apply option to the formatter.
        let assign: (DateComponentsFormatter) -> Void
        
        private init(assign: @escaping (DateComponentsFormatter) -> Void) {
            self.assign = assign
        }
        
        public static func allowedUnits(_ units: NSCalendar.Unit) -> Option {
            return Option { $0.allowedUnits = units }
        }
        
        public static func allowsFractionalUnits(_ allowed: Bool) -> Option {
            return Option { $0.allowsFractionalUnits = allowed }
        }
        
        public static func calendar(_ calendar: Calendar) -> Option {
            return Option { $0.calendar = calendar }
        }
        
        public static func collapsesLargestUnit(_ collapse: Bool) -> Option {
            return Option { $0.collapsesLargestUnit = collapse }
        }
        
        public static func includesApproximationPhrase(_ included: Bool) -> Option {
            return Option { $0.includesApproximationPhrase = included }
        }
        
        public static func includesTimeRemainingPhrase(_ included: Bool) -> Option {
            return Option { $0.includesTimeRemainingPhrase = included }
        }
        
        public static func maximumUnitCount(_ max: Int) -> Option {
            return Option { $0.maximumUnitCount = max }
        }
        
        public static func unitsStyle(_ style: DateComponentsFormatter.UnitsStyle) -> Option {
            return Option { $0.unitsStyle = style }
        }
        
        public static func zeroFormattingBehavior(_ behavior: DateComponentsFormatter.ZeroFormattingBehavior) -> Option {
            return Option { $0.zeroFormattingBehavior = behavior }
        }
        
        public static func custom(_ closure: @escaping (DateComponentsFormatter) -> Void) -> Option {
            return Option(assign: closure)
        }
    }
}

extension DateComponentsFormatter {
    /// Apply options to the formatter.
    func apply(options: [Option]) {
        options.forEach { $0.assign(self) }
    }
}

