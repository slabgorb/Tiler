//
//  TileView.swift
//  Tiler
//
//  Created by Keith Avery on 3/12/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit
import SnapKit

class TileView: UIView {
    var width: Double = TileView.defaultWidth
    var height: Double = TileView.defaultHeight

    enum Layer {
        case Background, Grid, Contents
    }

    static let defaultWidth = 144.0
    static let defaultHeight = 144.0
    let grid: UIImage? = UIImage(named: "grid")

    var tile: Tile? {
        didSet {
            self.layout()
        }
    }

    init(frame: CGRect, tile: Tile) {
        super.init(frame: frame)
        self.tile = tile
        layout()
    }
    
    convenience init(tile: Tile) {
        let  frame = CGRect(x: 0, y: 0, width: TileView.defaultWidth, height: TileView.defaultHeight)
        self.init(frame: frame, tile: tile)
    }
    
    func makeImageView(image: UIImage?, layer: Layer) -> UIImageView {
        let imageView = UIImageView(frame: self.frame)
        if var img =  image {
            if let tile = self.tile  {
                if layer == .Contents {
                    img = img.imageRotatedByDegrees(CGFloat(tile.rotation.toDegrees()), flipX: tile.flippedHorizontally, flipY: tile.flippedVertically)
                }
            }
            imageView.image = img
        }
        return imageView
    }
    
    func makeImageViewNamed(name: String, layer: Layer) -> UIImageView {
        return makeImageView(UIImage(named: name), layer: layer)
    }

    func clearImages() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }

    /**
     Responsible for laying out the image stack that draws the item. 
     */
    func layout() {
        clearImages()
        var imageViews:[UIImageView] = []
        if let backgroundName = tile?.backgroundImageName {
            imageViews.append(makeImageViewNamed(backgroundName, layer: .Background))
        }
        if let imageName = tile?.imageName {
            imageViews.append(makeImageViewNamed(imageName, layer: .Contents))
        }
        imageViews.append(makeImageView(grid, layer: .Grid))
        for imageView in imageViews {
            addSubview(imageView)
            imageView.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(0)
                make.left.equalTo(0)
                make.height.equalTo(self)
                make.width.equalTo(self)
            }
        }

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
