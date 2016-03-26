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
    var zoom: Double = 1.0

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
        drawTileView(tileView, row, column )
        return Either.Right(true)
    }

    private func drawTileView(tileView: TileView, _ row:Int, _ column: Int) {
        let rect = CGRect(x: Double(column) * TileView.height * self.zoom , y: Double(row) * TileView.width * self.zoom ,  width: TileView.width * self.zoom , height: TileView.height * self.zoom)
        tileView.frame = rect
        addSubview(tileView)
    }
}
