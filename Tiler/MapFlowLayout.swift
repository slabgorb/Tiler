//
//  MapFlowLayout.swift
//  Tiler
//
//  Created by Keith Avery on 4/9/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class TileAttributes: UICollectionViewLayoutAttributes {
    var row: Int = 0
    var column: Int = 0
}

class MapFlowLayout: UICollectionViewLayout {

    let horizontalInset:CGFloat = 0.0
    let verticalInset:CGFloat = 0.0

    let minimumItemWidth = CGFloat(TileView.defaultWidth)
    let maximumItemWidth = CGFloat(TileView.defaultWidth)
    let itemHeight = CGFloat(TileView.defaultHeight)

    private var layoutAttributes:[NSIndexPath:UICollectionViewLayoutAttributes] = [:]
    private var contentSize:CGRect = CGRectZero

    func shouldInvalidateLayoutForBoundsChange() -> Bool {
        return true
    }

    override func prepareLayout() {
        super.prepareLayout()
        if let sectionCount = collectionView?.numberOfSections() {
            for sectionIndex in 0..<sectionCount {
                if let itemCount = collectionView?.numberOfItemsInSection(sectionIndex) {
                    for itemIndex in 0..<itemCount {
                        let indexPath = NSIndexPath(forItem: itemIndex, inSection: sectionIndex)
                        layoutAttributes[indexPath] = layoutAttributesForItemAtIndexPath(indexPath)
                    }
                }
            }
        }
    }

    private func modifyLayoutAttributes(attributes: UICollectionViewLayoutAttributes) {
        if let cell = collectionView?.cellForItemAtIndexPath(attributes.indexPath) as? TileViewCell {
            if let row = cell.row, let column = cell.column {
                attributes.frame = CGRectMake(CGFloat(Double(row) * TileView.defaultWidth), CGFloat(Double(column) * TileView.defaultHeight), CGFloat(TileView.defaultWidth), CGFloat(TileView.defaultHeight))
            }
        }
    }

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes:UICollectionViewLayoutAttributes? = super.layoutAttributesForItemAtIndexPath(indexPath)
        if attributes != nil {
            modifyLayoutAttributes(attributes!)
        }
        return attributes
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesForElementsInRect:[UICollectionViewLayoutAttributes] = []
        for (_, attributes) in layoutAttributes {
            if CGRectIntersectsRect(rect, attributes.frame) {
                attributesForElementsInRect.append(attributes)
            }
        }
        return attributesForElementsInRect
    }

}
