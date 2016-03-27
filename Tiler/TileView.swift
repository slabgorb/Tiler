//
//  TileView.swift
//  Tiler
//
//  Created by Keith Avery on 3/12/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class TileView: UIView {
    static let width = 72.0
    static let height = 72.0
    let background: UIImage? = UIImage(named: "texture1")
    let grid: UIImage? = UIImage(named: "grid")
    //var image: UIImage?
    var tile: Tile!

    init(frame: CGRect, tile: Tile) {
        super.init(frame: frame)
        self.tile = tile
        layout()
    }
    
    convenience init(tile: Tile) {
        let  frame = CGRect(x: 0, y: 0, width: TileView.width, height: TileView.height)
        self.init(frame: frame, tile: tile)
    }
    
    func image() -> UIImage? {
        if (self.tile != nil) && (tile!.imageName != nil){
            if let image = UIImage(named: tile!.imageName!) {
                return image
            }
        }
        return nil
    }

    func makeImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView(frame: self.frame)
        var img = image
        if image != nil {
            if (self.tile != nil) {
                img = image?.imageRotatedByDegrees(CGFloat(tile!.rotation.toDegrees()), flipX: tile!.flippedHorizontally, flipY: tile!.flippedVertically)
            } else {
                img = image
            }
            imageView.image = img
        }

        return imageView
    }
    
    func layout() {
        addSubview(makeImageView(background))
        if let img = image() {
            addSubview(makeImageView(img))
        }
        addSubview(makeImageView(grid))
    }
    
    required init?(coder aDecoder: NSCoder, tile: Tile?) {
        self.tile = tile
        super.init(coder: aDecoder)
        layout()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder, tile:nil)
    }
    

    
}
