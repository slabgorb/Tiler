//
//  Map.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

enum MapError: ErrorType, Equatable {
    case TileDoesNotConnect
    case BadRow
    case BadColumn
}


func ==(lhs: MapError, rhs: MapError) -> Bool {
    switch (lhs, rhs) {
    case (.TileDoesNotConnect, .TileDoesNotConnect): return true
    case (.BadRow, .BadRow): return true
    case (.BadColumn, .BadColumn): return true
    default: return false
        
    }
}


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
    
    func getTileByRowAndColumn(row: Int, _ column: Int) -> Tile? {
        for tileEntry in tiles {
            if tileEntry.1[0] == row && tileEntry.1[1] == column {
                return tileEntry.0
            }
        }
        return nil
        
    }
    
   
    func add(tile: Tile, row: Int, column: Int) throws {
        // check for valid column
        guard row >= 0 else { throw MapError.BadRow }
        guard column >= 0 else { throw MapError.BadColumn }
        
        
        // check for matchability for the new tile
        let top = getTileByRowAndColumn(row - 1, column)
        let bottom = getTileByRowAndColumn(row + 1, column)
        let left = getTileByRowAndColumn(row, column - 1)
        let right = getTileByRowAndColumn(row, column + 1)
        
        guard (top ~ tile) && (bottom ~ tile) && (left ~ tile) && (right ~ tile) else { throw MapError.TileDoesNotConnect }
        
        tiles[tile] = [row, column]
    }
    
    func details() -> String {
        return "\(maxRow()):\(maxColumn())"
    }
    
    // MARK: Initializers
    init(title: String) {
        self.title = title
    }
    
    // MARK: Methods
}
