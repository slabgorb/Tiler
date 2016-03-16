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
    
    func addTileView(tileView: TileView, row: Int, column: Int)  -> Either<String,Bool> {
        
        if tileView.tile != nil {
            do {
                try map.add(tileView.tile!, row: row, column: column)
                self.tileViews[tileView] = [row, column]
            } catch MapError.TileDoesNotConnect  {
                return Either.Left("Could not add tile to map, does not connect")
            } catch MapError.BadColumn  {
                return Either.Left("Could not add tile to map, bad column")
            } catch MapError.BadRow  {
                return Either.Left("Could not add tile to map, bad row")
            } catch _ {
                return Either.Left("Unknown error adding tile")
            }
        }
        let rect = CGRect(x: Double(column) * TileView.height, y: Double(row) * TileView.width,  width: TileView.width, height: TileView.height)
        tileView.frame = rect
        addSubview(tileView)
        return Either.Right(true)
    }
}
