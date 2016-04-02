//
//  TileCustomizationViewController.swift
//  Tiler
//
//  Created by Keith Avery on 3/31/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class TileCustomizationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    @IBOutlet var collectionView: UICollectionView!

    var backgroundItems: [ImageItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initBackgroundItems()
        self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return backgroundItems.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BackgroundImageCell", forIndexPath: indexPath) as! BackgroundImageViewCell
        cell.setBackgroundItem(backgroundItems[indexPath.row])
        return cell
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    private func initBackgroundItems() {
        var items = [ImageItem]()
        if let inputFile = NSBundle.mainBundle().pathForResource("backgroundImages", ofType: "plist") {
            if let inputDataArray = NSArray(contentsOfFile: inputFile) {
                for item in inputDataArray as! [Dictionary<String, String>] {
                    let backgroundItem = ImageItem(key: "backgroundImage", dataDictionary: item)
                    items.append(backgroundItem)
                }
            }
        }
        self.backgroundItems = items
    }

}
