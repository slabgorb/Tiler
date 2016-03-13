//
//  Connection.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

class Connection: CustomStringConvertible {
    // MARK: Properties
    
    var from: Tile
    var to: Tile
    var direction: Direction
    var description:String {
        return "Connection from \(from) to \(to)"
    }
    
    // MARK: Initializers
    
    init(direction:Direction, from: Tile, to:Tile) {
        self.from = from
        self.to = to
        self.direction = direction
    }
    
}