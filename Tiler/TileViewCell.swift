//
//  TileViewCell.swift
//  Tiler
//
//  Created by Keith Avery on 4/12/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class TileViewCell: UICollectionViewCell {
    var tileView:TileView?
    var label: UILabel?
    override func layoutSubviews() {
        if let tileView = tileView, let label = label {
            addSubview(tileView)
            addSubview(label)
            label.snp_makeConstraints { make in
                make.centerY.equalTo(0)
                make.centerX.equalTo(0)
            }
            tileView.layout()
        }
        super.layoutSubviews()
    }
}
