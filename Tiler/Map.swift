//
//  Map.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

class Map: CustomStringConvertible {
    // MARK: Properties
    var tiles: [Tile:[Int]] = [:]
    var title: String?

    
    var description: String {
        var output:[String] =  ["MAP\n"]
        output.append("Rows: \(self.maxRow())")
        output.append("Columns: \(self.maxColumn())")
        for tile in tiles {
            output.append("Row: \(tile.1[0]) Column: \(tile.1[1])")
            output.append(tile.0.description)
        }
        return output.joinWithSeparator("\n\t")
    }

    func maxRow() -> Int {
        var maxV = 0
        for tile in tiles {
            maxV = max(maxV, tile.1[0])
        }
        return maxV
    }
    
    func maxColumn() -> Int {
        var maxV = 0
        for tile in tiles {
            maxV = max(maxV, tile.1[1])
        }
        return maxV
    }
    
    func add(tile: Tile, row: Int, column: Int) {
        tiles[tile] = [row, column]
    }
    
    
    
    // MARK: Initializers
    init(title: String) {
        self.title = title
    }
    
    // MARK: Methods
}
