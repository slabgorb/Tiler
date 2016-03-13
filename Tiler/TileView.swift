//
//  TileView.swift
//  Tiler
//
//  Created by Keith Avery on 3/12/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class TileView: UIView {
    static let width = 144.0
    static let height = 144.0
    let background: UIImage? = UIImage(named: "texture1")
    let grid: UIImage? = UIImage(named: "grid")
    var image: UIImage?
    var tile: Tile?
    
    init(tile:Tile, x:Double, y:Double) {
        self.tile = tile
        
        if (tile.imageName != nil) {
            if let image = UIImage(named: tile.imageName!) {
                self.image = image
            
            }
        }
        super.init(frame: CGRect(x: x, y: y, width: TileView.width, height: TileView.height))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
