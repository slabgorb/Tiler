//
//  MapView.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class MapView: UIView {
    var tileViews: [TileView] = []
    var map: Map
    required init?(coder aDecoder: NSCoder) {
        self.map = Map(title: "Untitled")
        super.init(coder: aDecoder)
    }
    
    func addTileView(tileView: TileView) {
        self.tileViews.append(tileView)
    }
}
