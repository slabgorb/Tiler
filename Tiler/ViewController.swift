//
//  ViewController.swift
//  Tiler
//
//  Created by Keith Avery on 3/3/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet var mapView: MapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let openings = [
            Opening(size: .Small, .North),
            Opening(size: .Small, .South)
        ]
        let tile = Tile(openings: openings, imageName: "straight")
        print(tile)
        self.mapView.addTileView(TileView(tile: tile))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

