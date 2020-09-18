//
//  Dictionary+Extensions.swift
//  OneKit
//
//  Created by yunhao on 2020/9/17.
//  Copyright © 2020 yunhao. All rights reserved.
//

import Foundation

public extension Dictionary {
    /// Returns a new dictionary containing the key-value pairs of the dictionary with the specified keys.
    ///
    ///     var fruits = ["apple": 10, "orange": 16, "banana": 5]
    ///     let result = fruits.only(["apple", "orange", "melon"])
    ///     print(result)
    ///     // Prints "["apple": 10, "orange": 16]"
    ///
    /// - Parameter keys: An array of keys indicates whether the pair should be included in the returned dictionary.
    /// - Returns: A dictionary whose keys are contained in the given keys array.
    func only(_ keys: [Key]) -> [Key: Value] {
        return filter { keys.contains($0.key) }
    }
    
    /// Returns a new dictionary containing all key-value pairs of the dictionary except for those with the specified keys.
    ///
    ///     var fruits = ["apple": 10, "orange": 16, "banana": 5]
    ///     let result = fruits.except(["apple", "orange", "melon"])
    ///     print(result)
    ///     // Prints "["banana": 5]"
    ///
    /// - Parameter keys: An array of keys indicates whether the pair should be excluded from the returned dictionary.
    /// - Returns: A dictionary whose keys are not contained in the given keys array.
    func except(_ keys: [Key]) -> [Key: Value] {
        return filter { !keys.contains($0.key) }
    }
}

