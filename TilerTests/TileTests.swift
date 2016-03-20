//
//  TileTests.swift
//  TilerTests
//
//  Created by Keith Avery on 3/3/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import XCTest
@testable import Tiler

class TileTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeadEnd() {
        let tile1 = Tile(openings:[Opening(.Small, .North)])
        let tile2 = Tile(openings:[Opening(.Small, .North), Opening(.Large, .East)])
        XCTAssert(tile1.isDeadEnd)
        XCTAssert(!tile2.isDeadEnd)
    }
    
    func testMatchingOpening() {
        let o1 = Opening(.Small, .North)
        let o2 = Opening(.Small, .South)
        XCTAssert(o1 ~ o2)
        let o3 = Opening(.Large, .North)
        let o4 = Opening(.Small, .South)
        XCTAssert(!(o3 ~ o4))
    }
    
    func testRotation() {
        let tile = Tile(openings:[Opening(.Small, .North)])
        tile.rotate(.Clockwise)
        XCTAssert(tile.rotation == .East)
        XCTAssert(tile.openings[0].direction == .East)
        tile.rotate(.Counterclockwise)
        XCTAssert(tile.rotation == .North)
        XCTAssert(tile.openings[0].direction == .North)

    }
    
    func testMatchingTile() {
        let tile1 = Tile(openings:[Opening(.Small, .North),Opening(.Large, .South)])
        let tile2 = Tile(openings:[Opening(.Small, .South),Opening(.Large, .East)])
        let tile3 = Tile(openings:[Opening(.Small, .North),Opening(.Large, .East)])
        XCTAssert(tile1 ~ tile2)
        XCTAssert(!(tile1 ~ tile3) )
    }
    
    func testRotatingMatch() {
        let openings = [
            Opening(.Small, .West),
            Opening(.Small, .North)
        ]
        let tile1 = Tile(openings:openings)
        let tile2 = Tile(openings:openings)
        tile1.rotate(.Counterclockwise)
        tile1.rotate(.Counterclockwise)
        print(tile1)
        print(tile2)
        XCTAssert(tile1 ~ tile2)
        tile1.rotate(.Clockwise)
        tile1.rotate(.Clockwise)
        print(tile1)
        print(tile2)
        XCTAssert(!(tile1 ~ tile2) )
    }
    

    
}
