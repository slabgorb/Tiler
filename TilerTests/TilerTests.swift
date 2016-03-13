//
//  TilerTests.swift
//  TilerTests
//
//  Created by Keith Avery on 3/3/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import XCTest
@testable import Tiler

class TilerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeadEnd() {
        let tile1 = Tile(openings:[Opening(size: .Small, .North)])
        let tile2 = Tile(openings:[Opening(size: .Small, .North), Opening(size: .Large, .East)])
        XCTAssert(tile1.isDeadEnd)
        XCTAssert(!tile2.isDeadEnd)
    }
    
    func testMatchingOpening() {
        let o1 = Opening(size: .Small, .North)
        let o2 = Opening(size: .Small, .South)
        XCTAssert(o1 ~ o2)
        let o3 = Opening(size: .Large, .North)
        let o4 = Opening(size: .Small, .South)
        XCTAssert(!(o3 ~ o4))
    }
    
    func testRotation() {
        let tile = Tile(openings:[Opening(size: .Small, .North)])
        tile.rotate(.Clockwise)
        XCTAssert(tile.rotation == .East)
        XCTAssert(tile.openings[0].direction == .East)
        tile.rotate(.Counterclockwise)
        XCTAssert(tile.rotation == .North)
        XCTAssert(tile.openings[0].direction == .North)

    }
    
    func testMatchingTile() {
        let tile1 = Tile(openings:[Opening(size: .Small, .North)])
        let tile2 = Tile(openings:[Opening(size: .Small, .South),Opening(size: .Large, .East)])
        let tile3 = Tile(openings:[Opening(size: .Small, .North),Opening(size:.Large, .East)])
        XCTAssert(tile1 ~ tile2)
        XCTAssert(!(tile1 ~ tile3) )
    }
    

    
}
