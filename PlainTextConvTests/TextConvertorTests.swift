//
//  TextConvertorTests.swift
//  PlainTextConv
//
//  Created by 酒井雄太 on 2017/06/11.
//  Copyright © 2017年 Yuuta Sakai. All rights reserved.
//

import XCTest
@testable import PlainTextConv

class TextConvertorTests: XCTestCase {
    
    let txtConv = TextConvertor()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        txtConv.plainText = "標準テキスト"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(txtConv.plainText == "標準テキスト")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
