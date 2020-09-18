//
//  UIFont+Extensions.swift
//  OneKit
//
//  Created by yunhao on 2020/9/17.
//  Copyright © 2020 yunhao. All rights reserved.
//

import UIKit

public extension UIFont {
    /// Returns a new font that is the same as the existing font, but with the specified symbolic traits.
    ///
    /// - Parameter traits: The new symbolic traits.
    /// - Returns: The new font.
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont? {
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else { return nil }
        return UIFont(descriptor: descriptor, size: 0)
    }

    /// Returns a new font  that is the same as the existing font, but with the bold trait.
    func bold() -> UIFont? {
        return withTraits(.traitBold)
    }

    /// Returns a new font  that is the same as the existing font, but with the italic trait.
    func italic() -> UIFont? {
        return withTraits(.traitItalic)
    }
}
