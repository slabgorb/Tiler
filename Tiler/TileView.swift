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
    var tile: Tile

    required init?(coder aDecoder: NSCoder) {
        let openings = [
            Opening(size: .Small, .North),
            Opening(size: .Small, .South)
        ]
        self.tile = Tile(openings: openings, imageName: "straight")
        
        if (tile.imageName != nil) {
            if let image = UIImage(named: tile.imageName!) {
                self.image = image
            
            }
            
        }
        super.init(coder: aDecoder)
        self.frame = CGRect(x: 0, y: 0, width: TileView.width, height: TileView.height)
        addSubview(UIImageView(image: background))
        addSubview(UIImageView(image: image))
        addSubview(UIImageView(image: grid))
        
    }
    

    
}
