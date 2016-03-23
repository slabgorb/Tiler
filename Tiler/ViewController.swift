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
    
    func addTile(tile: Tile, _ row: Int, _ column: Int) {
        let added:Either<String,Bool> = self.mapView.addTileView(TileView(tile: tile), row: row, column: column)
        switch added {
        case .Left(let errorText):
            print("Error adding tile \(errorText)")
//            let alert = UIAlertController(title: "Could not add tile", message: errorText, preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
        case .Right(_):
            print("added tile")
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stepperColumn.value = 1.0
        self.stepperRow.value = 1.0
        let openings = [
            Opening(.Small, .West),
            Opening(.Small, .North)

        ]
        let tile1 = Tile(openings: openings, imageName: "bend")
        let tile2 = Tile(openings: openings, imageName: "bend")
        let tile3 = Tile(openings: openings, imageName: "bend")
        let tile4 = Tile(openings: openings, imageName: "bend")
        tile1.rotate(.Clockwise)
        addTile(tile1, 0, 0)
        addTile(tile2, 0, 1)
        tile3.rotate(.Counterclockwise)
        addTile(tile3, 1, 1)
        tile4.rotate(.Clockwise)
        tile4.rotate(.Clockwise)
        addTile(tile4, 1, 0)

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

