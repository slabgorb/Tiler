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
    
    
    func addTile(tile: Tile, _ row: Int, _ column: Int) {
        let added:Either<String,Bool> = self.mapView.addTileView(TileView(tile: tile), row: row, column: column)
        switch added {
        case .Left(let errorText):
            HUD.flash(HUDContentType.LabeledError(title: "Error Adding Tile", subtitle: errorText), delay: 1.0)
        case .Right(_):
            print("added tile")
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.drawTiles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

