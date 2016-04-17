//
//  TileViewCell.swift
//  Tiler
//
//  Created by Keith Avery on 4/12/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class TileViewCell: UICollectionViewCell {
    var tileView:TileView? {
        didSet {
            if let tileView = self.tileView {
                tileView.layout()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        if let tileView = self.tileView {
            addSubview(tileView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
