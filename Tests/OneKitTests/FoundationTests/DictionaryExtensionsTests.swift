//
//  DictionaryExtensionsTests.swift
//  OneKitTests
//
//  Created by yunhao on 2020/9/18.
//  Copyright © 2020 yunhao. All rights reserved.
//

import XCTest

class DictionaryExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOnly() throws {
        let dict = [
            "apple": 12,
            "orange": 5,
            "banana": 20,
            "lemon": 15
        ]
        
        let target = [
            "apple": 12,
            "banana": 20,
        ]
        
        XCTAssertEqual(dict.only(["apple", "banana", "milk"]), target)
        XCTAssertEqual(dict.only(["milk"]), [:])
    }
    
    func testExcept() throws {
        let dict = [
            "apple": 12,
            "orange": 5,
            "banana": 20,
            "lemon": 15
        ]
        
        let target = [
            "orange": 5,
            "lemon": 15
        ]
        
        XCTAssertEqual(dict.except(["apple", "banana", "milk"]), target)
        XCTAssertEqual(dict.except(["milk"]), dict)
    }

}
