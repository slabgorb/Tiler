//
//  MapViewController.swift
//  Tiler
//
//  Created by Keith Avery on 3/3/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit
import PKHUD

class MapViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MapPersistence {

    // MARK: Properties

    @IBOutlet var mapView: MapView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleTextFieldRight: NSLayoutConstraint!
    

    @IBOutlet weak var finishedEditingTitleButton: UIButton!
    
    var map:Map? = Map(title: "Untitled")
    var mapIndex: Int = 0
    var mapList:MapList? 

    func addTile(tile: Tile, _ row: Int, _ column: Int) {
        let added:Either<String,Bool> = self.mapView.addTileView(TileView(tile: tile))
        switch added {
        case .Left(let errorText):
            HUD.flash(HUDContentType.LabeledError(title: "Error Adding Tile", subtitle: errorText), delay: 1.0)
        case .Right(_):
            print("added tile")
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TileCellId", forIndexPath: indexPath)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapList = loadMaps()
        mapView.map = mapList?.get(mapIndex)
        //mapView.drawTiles()
        navigationItem.title = map?.title
        titleTextField.text = map?.title
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Baskerville", size: 20)!]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func finishEditingTitle(sender: UIButton) {
        titleTextField.endEditing(true)
    }
    
    
    @IBAction func editTitle(sender: UITextField) {
        UIView.animateWithDuration(1.0, animations: {
            self.titleTextFieldRight.constant = self.finishedEditingTitleButton.frame.width + 16
            }, completion: { finished -> Void  in
                self.finishedEditingTitleButton.hidden = false
                
        })

    }
    
    @IBAction func changeTitle(sender: UITextField) {
        UIView.animateWithDuration(1.0, animations: {
            self.titleTextFieldRight.constant = 8
            }, completion: { finished -> Void  in
                self.finishedEditingTitleButton.hidden = true
                
        })
        if let map = self.map {
            map.title = sender.text
            navigationItem.title = map.title
        }
    }

}

