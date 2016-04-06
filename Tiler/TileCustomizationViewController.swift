//
//  TileCustomizationViewController.swift
//  Tiler
//
//  Created by Keith Avery on 3/31/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

enum CollectionViewType: Int {
    case Background = 0
    case Contents = 1

    func key() -> String {
        switch self {
        case .Background:
            return "backgroundItem"
        case .Contents:
            return "contentItem"
        }
    }
    func resource() -> String {
        return "\(key())s"
    }

}

class TileCustomizationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    @IBOutlet var collectionViews: [UICollectionView]!

    @IBOutlet weak var currentTile: TileView!
    
    var collectionViewItems: [CollectionViewType:[ImageItem]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        for cv in self.collectionViews {
            cv.registerClass(ImageViewCell.self, forCellWithReuseIdentifier: "ItemCell")
            let cvt:CollectionViewType = CollectionViewType.init(rawValue: cv.tag)!
            self.collectionViewItems[cvt] = self.initItems(cvt)
            cv.reloadData()

        }
        self.currentTile.tile = Tile(openings: [], imageName: "t", backgroundImageName: "texture1")
        self.currentTile.layout()   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, didDeSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            cell.backgroundColor = UIColor.whiteColor()
            cell.layer.borderColor = UIColor.blackColor().CGColor
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            cell.backgroundColor = UIColor.lightGrayColor()
            cell.layer.borderColor = UIColor.blueColor().CGColor
        }
        if let cvt = CollectionViewType.init(rawValue: collectionView.tag) {
            if let cvi = self.collectionViewItems[cvt] {
                switch cvt {
                case .Background:
                    if let tile = self.currentTile.tile {
                        tile.backgroundImageName = cvi[indexPath.row].name
                    }
                case .Contents:
                    if let tile = self.currentTile.tile {
                        tile.imageName = cvi[indexPath.row].name
                    }
                }
                self.currentTile.layout()
            }
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let cvt = CollectionViewType.init(rawValue: collectionView.tag) {
            if let cvi = self.collectionViewItems[cvt] {
                return cvi.count
            }
        }
        // else
        return 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var imageItem: ImageItem?
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath) as! ImageViewCell
        if let cvt =  CollectionViewType.init(rawValue: collectionView.tag) {
            if let cvi = self.collectionViewItems[cvt] {
                imageItem = cvi[indexPath.row]
            }
        }
        if let ii = imageItem {
            cell.setItem(ii)
        }
        return cell
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    private func initItems(collectionViewType: CollectionViewType) -> [ImageItem] {
        var items = [ImageItem]()
        if let inputFile = NSBundle.mainBundle().pathForResource(collectionViewType.resource(), ofType: "plist") {
            if let inputDataArray = NSArray(contentsOfFile: inputFile) {
                for dataDict in inputDataArray as! [Dictionary<String, String>] {
                    let imageItem = ImageItem(key: collectionViewType.key(), dataDictionary: dataDict)
                    items.append(imageItem)
                }
            }
        }
        return items
    }

}
