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


class Map: NSObject, NSCoding {
    // MARK: Properties
    var tiles: [Tile]
    var title: String?
    
    struct PropertyKey {
        static let tilesKey = "tiles"
        static let titleKey = "title"
    }
    
    override var description: String {
        var output:[String] =  ["MAP\n"]
        output.append("Rows: \(self.maxRow())")
        output.append("Columns: \(self.maxColumn())")
        for tile in tiles {
            output.append("Row: \(tile.row) Column: \(tile.column)")
            output.append(tile.description)
        }
        return output.joinWithSeparator("\n\t")
    }
    
    func details() -> String {
        return "\(maxRow()):\(maxColumn())"
    }
    
    // MARK:- Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("maps")
    
    // MARK:- Initializers
    convenience init(title: String) {
        self.init(title: title, tiles:[])
    }
    
    init(title:String, tiles:[Tile]) {
        self.title = title
        self.tiles = tiles
        
    }
    
    // MARK:- NSCoding
    required init?(coder aDecoder: NSCoder) {
        if let titleString = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as? String {
            self.title = titleString
        }
        if let tilesArray = aDecoder.decodeObjectForKey(PropertyKey.tilesKey) as? [Tile] {
            self.tiles = tilesArray
        } else {
            self.tiles = []
        }

    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(tiles, forKey:PropertyKey.tilesKey)
        aCoder.encodeObject(title, forKey:PropertyKey.titleKey)
    }
    // MARK: Methods
    func maxRow() -> Int {
        guard self.tiles.count > 0 else { return 0 }
        return Int(self.tiles.flatMap({$0.row}).maxElement()!)
    }
    func maxColumn() -> Int {
        guard self.tiles.count > 0 else { return 0 }
        return Int(self.tiles.flatMap({$0.column}).maxElement()!)
    }
    
    func getTileByRowAndColumn(row: Int, _ column: Int) -> Tile? {
        for tile in self.tiles {
            if tile.row == row && tile.column == column {
                return tile
            }
        }
        return nil
    }
    
    /**
     Remove a tile from the map.
    */
    func remove(tile: Tile) -> Void {
        if let index = self.tiles.indexOf(tile) {
            self.tiles.removeAtIndex(index)
        }
    }
    
    /**
     Remove a tile specified by row/column
     */
    func remove(row:Int, _ column: Int) -> Void {
        if let tile = getTileByRowAndColumn(row, column) {
            self.remove(tile)
        }
    }
    
     
    /**
     Replace a tile
    */
     
    
    /**
     Add a tile to the map.
     */
    func add(tile: Tile) throws {
        // check for valid column
        guard tile.row >= 0 else { throw MapError.BadRow }
        guard tile.column >= 0 else { throw MapError.BadColumn }
        guard tile.row <= maxRow() + 1 else { throw MapError.BadRow }
        guard tile.column <= maxColumn() + 1 else { throw MapError.BadColumn }
        
        // check for matchability for the new tile
        let top = getTileByRowAndColumn(tile.row - 1, tile.column)
        let bottom = getTileByRowAndColumn(tile.row + 1, tile.column)
        let left = getTileByRowAndColumn(tile.row, tile.column - 1)
        let right = getTileByRowAndColumn(tile.row, tile.column + 1)
        guard (top ~ tile) && (bottom ~ tile) && (left ~ tile) && (right ~ tile) else { throw MapError.TileDoesNotConnect }

        // OK, all good, add it in
        tiles.append(tile)
    }
}
