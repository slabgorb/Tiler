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
        if let map = self.map {
            for tile in map.tiles {
                tileViews.append(TileView(tile: tile))
            }
        }
        for view in tileViews {
            drawTileView(view)
        }
        drawBlankTiles()
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

    private func rectForLocation(row row: Int, column: Int) -> CGRect {
        return CGRect(x: Double(column) * TileView.defaultWidth * self.zoom , y: Double(row) * TileView.defaultWidth * self.zoom ,  width: TileView.defaultWidth * self.zoom , height: TileView.defaultHeight * self.zoom)
    }
    
    private func drawTileView(tileView: TileView) {
        let rect = rectForLocation(row: tileView.tile!.row, column: tileView.tile!.column)
        tileView.frame = rect
        addSubview(tileView)
    }
    
    private func drawBlankTile(rect: CGRect) {
        let view = UIView(frame: rect)
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(named: .LightBorder).CGColor
        view.backgroundColor = UIColor(named: .Overlay)
        addSubview(view)
    }
    
    private func drawBlankTiles() {
        if let maxRow = map?.maxRow(), let maxCol = map?.maxColumn() {
            for i in 0...maxRow {
                drawBlankTile(rectForLocation(row: i, column: maxCol + 1))
            }
            for i in 0...maxCol {
                drawBlankTile(rectForLocation(row: maxRow + 1, column: i))
            }
        }
    }
}
