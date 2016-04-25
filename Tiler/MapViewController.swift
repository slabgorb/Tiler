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

    var map:Map? = Map(title: "Untitled")

    var mapIndex: Int = 0
    var mapList:MapList? 

    override func viewDidLoad() {
        super.viewDidLoad()
        let mapList = loadMaps()
        map = mapList?.get(mapIndex)
        navigationItem.title = map?.title
        
    }

//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        mapView.reloadData()
//
//
//    }

//    func addTile(tile: Tile, _ row: Int, _ column: Int) {
//        let added:Either<String,Bool> = self.mapView.addTileView(TileView(tile: tile))
//        switch added {
//        case .Left(let errorText):
//            HUD.flash(HUDContentType.LabeledError(title: "Error Adding Tile", subtitle: errorText), delay: 1.0)
//        case .Right(_):
//            print("added tile")
//        }
//    }

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
    
    func saveMap() {
        mapList = loadMaps()
        if let map = map, mapList = mapList {
            mapList[mapIndex] =  map
            saveMaps()
        }
        mapView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "expandTileSegueId":
                if let navigationController = segue.destinationViewController as? UINavigationController  {
                    if let viewController = navigationController.topViewController as? TileCustomizationViewController {
                        if let currentSelection = mapView.indexPathsForSelectedItems()?.first {
                            if let tile = map?.tiles[currentSelection.row] {
                                viewController.mapDelegate = self
                                viewController.tile = tile
                            }
                        }
                    }
                }
            case "newTileSegueId":
                if let navigationController = segue.destinationViewController as? UINavigationController  {
                    if let viewController = navigationController.topViewController as? TileCustomizationViewController {
                        viewController.mapDelegate = self
                        viewController.tile = nil
                    }
                    
                }
            default:
                break
            }

        }

    }

}
// MARK:- UICollectionViewDelegate
extension MapViewController: UICollectionViewDelegate {
    
}

extension MapViewController: MapDelegate {
    func add(tile: Tile) {
        do {
            try map!.add(tile)
        } catch let error as NSError {
            print(error.description)
        }
    }
}


// MARK:- UICollectionViewDataSource
extension MapViewController: UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        var count:Int = 0
        if let maxRow = map?.maxRow() {
            count =  maxRow + 1
        }
        return count
    }

    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int = 0
        if let map = self.map {
            count =  map.maxColumnInRow(section) + 1
        }
        return count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TileCellId", forIndexPath: indexPath) as! TileViewCell

        if let map = self.map {
            let tileRow = map.tilesInRow(indexPath.section)
            if tileRow.count > 0 {
                let tile = tileRow[indexPath.row]
                let tileView = TileView(tile:tile)
                cell.tileView = tileView
            }
            cell.label = UILabel()
            cell.label?.text = "\(indexPath.section):\(indexPath.row)"
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
            saveMap()
            navigationItem.title = map.title
        }
        removeTextInputViewController()
    }


}

