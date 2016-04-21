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
            row = tileView?.tile?.row
            column = tileView?.tile?.column
        }
    }

    var row:Int?
    var column: Int?

    override func layoutSubviews() {
        if let tileView = tileView {
            addSubview(tileView)
            tileView.layout()
        }
        super.layoutSubviews()
    }
}
