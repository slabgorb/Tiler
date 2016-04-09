//
//  RomanNumeralTests.swift
//  Tiler
//
//  Created by Keith Avery on 4/6/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import XCTest
@testable import Tiler

class RomanNumeralTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testRomanNumerals() {
        XCTAssert(5.toRoman() == "V")
        XCTAssert(6.toRoman() == "VI")
        XCTAssert(2016.toRoman() == "MMXVI")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
