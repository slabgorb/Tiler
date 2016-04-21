//
//  MapViewController.swift
//  Tiler
//
//  Created by Keith Avery on 3/3/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit
import PKHUD

class MapViewController: UIViewController {

    // MARK: Properties

    @IBOutlet var mapView: MapView!

    var textInputViewController: TextInputViewController?

    var map:Map? = Map(title: "Untitled") {
        didSet {
            self.mapView.map = map
        }
    }


    var mapIndex: Int = 0
    var mapList:MapList? 

    override func viewDidLoad() {
        super.viewDidLoad()
        let mapList = loadMaps()
        map = mapList?.get(mapIndex)
        navigationItem.title = map?.title
        
    }

    func addTile(tile: Tile, _ row: Int, _ column: Int) {
        let added:Either<String,Bool> = self.mapView.addTileView(TileView(tile: tile))
        switch added {
        case .Left(let errorText):
            HUD.flash(HUDContentType.LabeledError(title: "Error Adding Tile", subtitle: errorText), delay: 1.0)
        case .Right(_):
            print("added tile")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func unwindToList(segue: UIStoryboardSegue) {
    }

    @IBAction func renameMap(sender: AnyObject?) {
        removeTextInputViewController()
        self.textInputViewController = TextInputViewController()
        if let textInputViewController = self.textInputViewController {
            textInputViewController.delegate = self
            self.addChildViewController(textInputViewController)
            self.view.addSubview(textInputViewController.view)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "expandTileSegueId" {
            if let navigationController = segue.destinationViewController as? UINavigationController  {
                if let viewController = navigationController.topViewController as? TileCustomizationViewController {
                    viewController.currentTile.tile = map?.tiles[mapView.indexPathsForSelectedItems()![0].row]
                }
            }
        }
    }

}
// MARK:- UICollectionViewDelegate
extension MapViewController: UICollectionViewDelegate {

}


// MARK:- UICollectionViewDataSource
extension MapViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let map = self.map {
            return map.tiles.count
        } else {
            return 1
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TileCellId", forIndexPath: indexPath) as! TileViewCell

        if let map = self.map {
            let tile = map.tiles[indexPath.row]
            let tileView = TileView(frame: cell.frame, tile:tile)
            cell.tileView = tileView
        }
        return cell
    }
}

// MARK:- MapPersistence
extension MapViewController: MapPersistence {

}

// MARK:- TextInputViewControllerDelegate
extension MapViewController: TextInputViewControllerDelegate {

    func textInputViewControllerCancelButtonTapped(viewController: TextInputViewController) {
        removeTextInputViewController()
    }

    func textInputViewController(viewController: TextInputViewController, saveButtonTappedWithText text:String) {
        if let map = map {
            map.title = text
            mapList = loadMaps()
            mapList![mapIndex] =  map
            saveMaps()
            navigationItem.title = map.title
        }
        removeTextInputViewController()
    }


}

