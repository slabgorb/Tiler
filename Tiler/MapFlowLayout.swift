//
//  MapFlowLayout.swift
//  Tiler
//
//  Created by Keith Avery on 4/9/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class MapFlowLayout: UICollectionViewFlowLayout {
    
    override var itemSize: CGSize {
        set {
            
        }
        get {
            return CGSize(width: TileView.defaultWidth, height: TileView.defaultHeight)
        }
    }
    
    override init() {
        super.init()
        setupLayout()
        
    }
    
    func setupLayout() {
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
}
