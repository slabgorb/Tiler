//
//  BackgroundImageViewCell.swift
//  Tiler
//
//  Created by Keith Avery on 4/1/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class BackgroundImageViewCell: UICollectionViewCell {
    @IBOutlet var itemImageView: UIImageView!
    func setBackgroundItem(item:ImageItem) {
        itemImageView.image = UIImage(named: item.name)
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1
    }
}