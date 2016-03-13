//
//  Map.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

class Map {
    var tiles: [Tile] = []
    var title: String?
    
    init(title: String) {
        self.title = title
    }
}
