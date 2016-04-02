//
//  ImageViewCell.swift
//  Tiler
//
//  Created by Keith Avery on 4/1/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    func setItem(item: ImageItem) {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        imageView.image = UIImage(named: item.name)
        self.addSubview(imageView)
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1

    }

}
