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

    var collectionViewItems: [CollectionViewType:[ImageItem]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        for cv in self.collectionViews {
            cv.registerClass(ImageViewCell.self, forCellWithReuseIdentifier: "ItemCell")
            let cvt:CollectionViewType = CollectionViewType.init(rawValue: cv.tag)!
            self.collectionViewItems[cvt] = self.initItems(cvt)
            cv.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
