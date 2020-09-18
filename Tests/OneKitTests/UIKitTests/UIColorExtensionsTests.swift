//
//  UIColorExtensionsTests.swift
//  OneKitTests
//
//  Created by yunhao on 2020/9/17.
//  Copyright © 2020 yunhao. All rights reserved.
//

import XCTest
import OneKit

class UIColorExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitWithIntRGBA() {
        let components = (r: 238, g: 85, b: 119, a: CGFloat(0.5))
        let color1 = UIColor(intRed: components.r, green: components.g, blue: components.b)
        let color2 = UIColor(intRed: components.r, green: components.g, blue: components.b, alpha: 0.5)
        
        // If the alpha parameter is correct.
        XCTAssertEqual(color1, color2.withAlphaComponent(1.0))
        XCTAssertEqual(color1.withAlphaComponent(0.5), color2)
        
        // If the component values are correct.
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color2.getRed(&r, green: &g, blue: &b, alpha: &a)
        XCTAssert(components == (Int(r * 255), Int(g * 255), Int(b * 255), a))
    }
    
    func testInitWithHexString() {
        XCTAssertNil(UIColor(hexString: "E75A7C"))
        XCTAssertNil(UIColor(hexString: "#E7"))
        XCTAssertNil(UIColor(hexString: "#E75A7C8"))
        XCTAssertNil(UIColor(hexString: "#E75A7C8A9"))
        
        let pack = ColorPack.make()
        
        XCTAssertEqual(pack.color, UIColor(hexString: pack.hex3String, alpha: pack.alpha))
        XCTAssertEqual(pack.color, UIColor(hexString: pack.hex6String, alpha: pack.alpha))
    }

    func testHexString() {
        let pack = ColorPack.make()
        XCTAssertEqual(pack.hex6String, pack.color.hex6String)
    }

    func testDarken() {
        let color = ColorPack.make().color
        var h1: CGFloat = 0, s1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        color.getHue(&h1, saturation: &s1, brightness: &b1, alpha: &a1)

        var darkerColor = color.darkened(by: 0.2)
        var h2: CGFloat = 0, s2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        darkerColor.getHue(&h2, saturation: &s2, brightness: &b2, alpha: &a2)
        
        XCTAssertEqual(h1, h2)
        XCTAssertEqual(s1, s2)
        XCTAssertEqual(b1 * (1 - 0.2), b2)
        
        darkerColor = color.darkened(by: 0.2, clamp: true)
        darkerColor.getHue(&h2, saturation: &s2, brightness: &b2, alpha: &a2)
        
        XCTAssertEqual(h1, h2)
        XCTAssertEqual(s1, s2)
        XCTAssertEqual(max(b1 * (1 - 0.2), 0), b2)
    }
    
    func testLighten() {
        let color = ColorPack.make().color
        var h1: CGFloat = 0, s1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        color.getHue(&h1, saturation: &s1, brightness: &b1, alpha: &a1)

        var lighterColor = color.lightened(by: 0.2)
        var h2: CGFloat = 0, s2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        lighterColor.getHue(&h2, saturation: &s2, brightness: &b2, alpha: &a2)
        
        XCTAssertEqual(h1, h2)
        XCTAssertEqual(s1, s2)
        XCTAssertEqual(b1 * (1 + 0.2), b2)
        
        lighterColor = color.lightened(by: 0.2, clamp: true)
        lighterColor.getHue(&h2, saturation: &s2, brightness: &b2, alpha: &a2)
        
        XCTAssertEqual(h1, h2)
        XCTAssertEqual(s1, s2)
        XCTAssertEqual(min(b1 * (1 + 0.2), 1), b2)
    }
}

struct ColorPack {
    let color: UIColor
    let intRGB: (Int, Int, Int)
    let alpha: CGFloat
    let hex3String: String
    let hex6String: String
    
    private init(color: UIColor, intRGB: (Int, Int, Int), alpha: CGFloat, hex3String: String, hex6String: String) {
        self.color = color
        self.intRGB = intRGB
        self.alpha = alpha
        self.hex3String = hex3String
        self.hex6String = hex6String
    }
    
    static func make() -> ColorPack {
        let intRGB = (r: 238, g: 85, b: 119)
        let alpha: CGFloat = 0.5
        let color = UIColor(
            red: CGFloat(intRGB.r) / 255.0,
            green: CGFloat(intRGB.g) / 255.0,
            blue: CGFloat(intRGB.b) / 255.0,
            alpha: alpha
        )
        
        let hex3String = "#E57"
        let hex6String = "#EE5577"
        
        return ColorPack(
            color: color,
            intRGB: intRGB,
            alpha: alpha,
            hex3String: hex3String,
            hex6String: hex6String
        )
    }
}
