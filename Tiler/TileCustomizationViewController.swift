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

    var backgroundItems: [BackgroundItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initBackgroundItems()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func initBackgroundItems() {
        var items = [BackgroundItem]()
        if let inputFile = NSBundle.mainBundle().pathForResource("backgroundImages", ofType: "plist") {
            if let inputDataArray = NSArray(contentsOfFile: inputFile) {
                for item in inputDataArray as! [Dictionary<String, String>] {
                    let backgroundItem = BackgroundItem(dataDictionary: item)
                    items.append(backgroundItem)
                }
            }
        }
    }

}
