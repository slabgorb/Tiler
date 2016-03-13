//
//  MapView.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class MapView: UIView {
    var tileViews: [TileView:[Int]] = [:]
    var map: Map
    required init?(coder aDecoder: NSCoder) {
        self.map = Map(title: "Untitled")
        super.init(coder: aDecoder)
    }
    
    func addTileView(tileView: TileView, row: Int, column: Int) {
        self.tileViews[tileView] = [row, column]
        map.tiles.append(tileView.tile, row, column)
        let rect = CGRect(x: Double(column) * TileView.height, y: Double(row) * TileView.width,  width: TileView.width, height: TileView.height)
        tileView.frame = rect
        addSubview(tileView)
    }
}
