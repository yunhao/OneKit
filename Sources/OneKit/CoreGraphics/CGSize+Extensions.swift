//
//  CGSize+Extensions.swift
//  OneKit
//
//  Created by yunhao on 2020/9/17.
//  Copyright © 2020 yunhao. All rights reserved.
//

import CoreGraphics

public extension CGSize {
    
    /// Returns the new size as the result of multiplying by the given factor.
    ///
    ///     let size = CGSize(width: 2, height: 3)
    ///     let newSize = size.multiplied(by: 4)
    ///     // (width: 8, height: 12)
    ///
    /// - Parameter factor: The factor value.
    /// - Returns: A new size.
    func multiplied(by factor: CGFloat) -> CGSize {
        return CGSize(width: width * factor, height: height * factor)
    }
}
