//
//  UIColor+Extensions.swift
//  OneKit
//
//  Created by yunhao on 2020/9/17.
//  Copyright © 2020 yunhao. All rights reserved.
//

import UIKit

// MARK: - Initializers

public extension UIColor {
    
    /// Creates a color object using the specified RGB components and an optional alpha value.
    ///
    ///     // A red color.
    ///     let red = UIColor(red: 255, green: 0, blue: 0)
    ///
    ///     // A white color.
    ///     let white = UIColor(red: 255, green: 255, blue: 255)
    ///
    /// The `red`, `green` and `blue` parameter are components of the color object. Each one is specified as a value from 0 to 255.
    /// On applications linked for iOS 10 or later, the color is specified in an extended color space, and the input value is never clamped.
    /// On earlier versions of iOS, values below 0 are interpreted as 0, and values above 255 are interpreted as 255.
    ///
    /// - Parameters:
    ///   - red: The red component of the color object, specified as a value from 0 to 255.
    ///   - green: The green component of the color object, specified as a value from 0 to 255.
    ///   - blue: The blue component of the color object, specified as a value from 0 to 255.
    ///   - alpha: The alpha value of the color object, specified as a value from 0 .0 to 1.0, the default value is 1.0. Alpha values
    ///     below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0. The default value is 1.0.
    /// - Returns: The color object. The color information represented by this object is in an RGB colorspace. On applications linked
    ///     for iOS 10 or later, the color is specified in an extended range sRGB color space. On earlier versions of iOS, the color is
    ///     specified in a device RGB colorspace.
    convenience init(intRed red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }

    /// Creates a color object using the specified hex color string and an optional opacity.
    ///
    ///     let red = UIColor(hexString: "#FF0000")     // 6-digit
    ///     let green = UIColor(hexString: "#0F0")      // 3-digit
    ///
    /// - Parameters:
    ///   - hexString: A hex color string, represents the color value, starts with a `#` character. The string can be a 3-digit or an
    ///     6-digit hexadecimal representation.
    ///   - alpha: A alpha value.
    /// - Returns: The color object. The color information represented by this object is in an RGB colorspace.
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        // Hex color string must start with a `#` prefix.
        guard let prefixIndex = hexString.firstIndex(of: "#") else { return nil }
        var hexColor = hexString.suffix(from: hexString.index(after: prefixIndex))
        // Convert to a 8-digit format.
        switch hexColor.count {
        case 3: hexColor = hexColor.reduce(into: "") { $0 += String(repeating: $1, count: 2) } + "FF"
        case 6: hexColor += "FF"
        default: return nil
        }
        // Convert hex string to hex value.
        guard let hexValue = UInt64(hexColor, radix: 16) else { return nil }
        self.init(hex6: hexValue, alpha: alpha)
    }
    
    /// Creates a color object using a 6-digit hex value.
    private convenience init?(hex6: UInt64, alpha: CGFloat) {
        let r = CGFloat((hex6 >> 24) & 0xff) / 255
        let g = CGFloat((hex6 >> 16) & 0xff) / 255
        let b = CGFloat((hex6 >> 8) & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

// MARK: - Hex String

public extension UIColor {
    
    /// Return a 6-digit hex string representation of the color value.
    ///
    ///     let hex6 = color.hex6String    // "#2264B7"
    ///
    /// This function return a 6-digit hex color string in `#RRGGBB` format.
    ///
    /// - Returns: A hex string represents the color value. The format is a `#RRGGBB`.
    var hex6String: String {
        // Get rgba components.
        let components: [Int] = {
            let cps = cgColor.components!
            // Convert to rgba format if needed.
            let rgba = [CGFloat](repeating: cps[0], count: 4 - cps.count) + cps
            return rgba.map { Int($0 * 255.0) }
        }()
        
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
}

// MARK: - Adjust Color

public extension UIColor {
    
    
    /// Adjust color brightness by percentage.
    private func adjustBrightness(by percentage: CGFloat, clamp: Bool) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }
        
        b = (1 + percentage) * b
        if clamp { b = max(min(b, 1), 0) }
        
        return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    /// Return a darker color.
    ///
    ///     let darkerColor = color.darkened(by: 0.2)
    ///
    /// On applications linked for iOS 10 or later, the color is specified in an extended color space, and the input value is never clamped
    /// by default. Set `clamp` to `true` to clamp values to ensure they fit within the range 0.0 to 1.0.
    ///
    /// - Parameters:
    ///   - percentage: The percentage value used to darken the color, specified as a value from 0.0 to 1.0.
    ///   - clamp: A boolean value indicates whether to clamp components to fit inside the color gamut, meaning that component
    ///     values below 0.0 will be interpreted as 0.0 and values above 1.0 will be interpreted as 1.0. The default value is false.
    /// - Returns: A darkened color.
    func darkened(by percentage: CGFloat, clamp: Bool = false) -> UIColor {
        adjustBrightness(by: -percentage, clamp: clamp)
    }
    
    /// Return a lighter color.
    ///
    ///     let lighterColor: UIColor = color.lightened(by: 0.2)
    ///
    /// On applications linked for iOS 10 or later, the color is specified in an extended color space, and the input value is never clamped
    /// by default. Set `clamp` to `true` to clamp values to ensure they fit within the range 0.0 to 1.0.
    ///
    /// - Parameters:
    ///   - percentage: The percentage value used to lighter the color specified as a value from 0.0 to 1.0.
    ///   - clamp: A boolean value indicates whether to clamp components to fit inside the color gamut, meaning that component
    ///     values below 0.0 will be interpreted as 0.0 and values above 1.0 will be interpreted as 1.0. The default value is false.
    /// - Returns: A lightened color.
    func lightened(by percentage: CGFloat, clamp: Bool = false) -> UIColor {
        adjustBrightness(by: percentage, clamp: clamp)
    }
}


