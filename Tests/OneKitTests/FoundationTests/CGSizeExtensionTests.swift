//
//  CGSizeExtensionTests.swift
//  OneKitTests
//
//  Created by yunhao on 2020/9/18.
//  Copyright © 2020 yunhao. All rights reserved.
//

import XCTest

class CGSizeExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMultiplyByCGFloat() {
        let size = CGSize(width: 3.5, height: 5.2)
        let newSize = size.multiplied(by: 4.0)
        
        XCTAssertEqual(newSize, CGSize(width: 14, height: 20.8))
    }

}
