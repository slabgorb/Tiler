//
//  MapView.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class MapView: UIView {
    var map: Map?
    var zoom: Double = 1.0
    var tileViews:[TileView] = []

    func drawTiles() {
        tileViews = []
        if map != nil {
            for tile in map!.tiles {
                tileViews.append(TileView(tile: tile))
            }
        }
        for view in tileViews {
            drawTileView(view)
        }
    }
    
    func addTileView(tileView: TileView)  -> Either<String,Bool> {
        
        if tileView.tile != nil {
            do {
                try map?.add(tileView.tile!)
                self.tileViews.append(tileView)
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
        drawTileView(tileView)
        return Either.Right(true)
    }

    private func drawTileView(tileView: TileView) {
        let rect = CGRect(x: Double(tileView.tile!.column) * TileView.defaultWidth * self.zoom , y: Double(tileView.tile!.row) * TileView.defaultWidth * self.zoom ,  width: TileView.defaultWidth * self.zoom , height: TileView.defaultHeight * self.zoom)
        tileView.frame = rect
        addSubview(tileView)
    }
}
