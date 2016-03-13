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
    var tiles: [Tile] = []
    var title: String?
    
    var description: String {
        var output:[String] =  ["MAP\n"]
        for tile in tiles {
            output.append(tile.description)
        }
        return output.joinWithSeparator("\n\t")
    }
    
    // MARK: Initializers
    init(title: String) {
        self.title = title
    }
    
    // MARK: Methods
}
