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
    
    @IBOutlet weak var buttonAdd: UIButton!

    @IBOutlet weak var lblRow: UILabel!
    @IBOutlet weak var lblColumn: UILabel!
    @IBOutlet weak var stepperRow: UIStepper!
    @IBOutlet weak var stepperColumn: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stepperColumn.value = 1.0
        self.stepperRow.value = 1.0
        let openings = [
            Opening(size: .Small, .North),
            Opening(size: .Small, .South)
        ]
        let tile = Tile(openings: openings, imageName: "straight")
        self.mapView.addTileView(TileView(tile: tile), row: 0, column: 0)
        self.mapView.addTileView(TileView(tile: tile), row: 1, column: 0)
        self.mapView.addTileView(TileView(tile: tile), row: 0, column: 1)
        tile.rotate(.Clockwise)
        self.mapView.addTileView(TileView(tile: tile), row: 1, column: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Mark: Actions
    
    @IBAction func stepperRowChange(sender: UIStepper) {
        lblRow.text = String(Int(sender.value))
    }

    @IBAction func stepperColumnChange(sender: UIStepper) {
        lblColumn.text = String(Int(sender.value))
    }

    @IBAction func buttonAddPress(sender: UIButton) {
        // add a new tile or replace the tile at row/column
        let row = Int(lblRow.text!)
        let column = Int(lblColumn.text!)
        print("Would add tile at \(row) : \(column)")
    }
}

