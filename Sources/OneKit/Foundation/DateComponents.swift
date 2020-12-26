//
//  File.swift
//  
//
//  Created by yunhao on 2020/10/21.
//

import Foundation

public extension DateComponents {
    
    /// Returns a formatted string based on the current date component information.
    func string(options: [DateComponentsFormatter.Option] = []) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.apply(options: options)
        return formatter.string(from: self)
    }
}
