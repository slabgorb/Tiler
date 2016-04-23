//
//  MapDelegate.swift
//  Tiler
//
//  Created by Keith Avery on 4/21/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation


protocol MapDelegate {
    func add(tile: Tile) 
    func saveMaps()
    func saveMap()
}