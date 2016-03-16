//
//  MapTests.swift
//  TilerTests
//
//  Created by Keith Avery on 3/14/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import XCTest
@testable import Tiler

class MapTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddTile() {
        let testMap = Map(title: "Test Map")
        let tile1 = Tile(openings:[Opening(.Small, .North)])
        let tile2 = Tile(openings:[Opening(.Small, .South), Opening(.Large, .East)])
        try! testMap.add(tile1, row: 0, column: 0)
        try! testMap.add(tile2, row: 1, column: 0)
        XCTAssert(testMap.maxColumn() == 0)
        XCTAssert(testMap.maxRow() == 1)
    }

    func testFailAddTile() {
        let testMap = Map(title: "Test Map")
        let tile1 = Tile(openings:[Opening(.Small, .North)])
        let tile2 = Tile(openings:[Opening(.Small, .North), Opening(.Large, .East)])
        do {
            try testMap.add(tile1,row: 0,column: 0)
            try testMap.add(tile2,row: 0,column: 1)
        }
        catch let e as MapError {
            XCTAssertEqual(e, MapError.TileDoesNotConnect)
        }
        catch {
            XCTFail("Wrong error")
        }
        do {
            try testMap.add(tile2, row: -1, column: 0)
            
        }
        catch let e as MapError {
            XCTAssertEqual(e, MapError.BadRow)
        }
        catch {
            XCTFail("Wrong error")
        }
        do {
            try testMap.add(tile2, row: 0, column: -1)
            
        }
        catch let e as MapError {
            XCTAssertEqual(e, MapError.BadColumn)
        }
        catch {
            XCTFail("Wrong error")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
