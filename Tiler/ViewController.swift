//
//  ViewController.swift
//  Tiler
//
//  Created by Keith Avery on 3/3/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController {

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

    /**
     Load a map into the map view.
     
     Parameter map: map to load
     */
    func loadMap(map:Map) {

        let openings = [
            Opening(.Small, .West),
            Opening(.Small, .North)
        ]
        let tile1 = Tile(openings: openings, imageName: "bend", backgroundImageName: "")
        let tile2 = Tile(openings: openings, imageName: "bend", backgroundImageName: "")
        let tile3 = Tile(openings: openings, imageName: "bend", backgroundImageName: "")
        let tile4 = Tile(openings: openings, imageName: "bend", backgroundImageName: "")
        tile1.rotate(.Clockwise)
        addTile(tile1, 0, 0)
        addTile(tile2, 0, 1)
        tile3.rotate(.Counterclockwise)
        addTile(tile3, 1, 1)
        tile4.rotate(.Clockwise)
        tile4.rotate(.Clockwise)
        addTile(tile4, 1, 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let testFile = FileSaveHelper(fileName: "testFile", fileExtension: .TXT, subDirectory: "SavingFiles", directory: .DocumentDirectory)

        //loadMap(Map(title:"Untitled"))
        
        print("Directory exists: \(testFile.directoryExists)")
        print("File exists: \(testFile.fileExists)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

