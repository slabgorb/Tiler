//
//  MapListTableViewController.swift
//  Tiler
//
//  Created by Keith Avery on 3/26/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class MapListTableViewController: UITableViewController {

    var mapList:MapList?
    var selectedMap: Map?
    
    @IBOutlet weak var editMapBarButton: UIBarButtonItem!
    @IBOutlet weak var addMapBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedMaps = loadMaps() {
            if savedMaps.count > 0 {
                mapList = savedMaps
            } else {
                mapList = loadSampleMaps()
            }
        } else {
            mapList = loadSampleMaps()
        }
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = mapList?.count {
            return count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MapTableViewCell {
        let cell:MapTableViewCell = tableView.dequeueReusableCellWithIdentifier("mapTableCell", forIndexPath: indexPath) as! MapTableViewCell
        if let ml = self.mapList {
            let map = ml.get(indexPath.row)
            cell.loadItem(map)
        }
        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedMap = mapList!.get(indexPath.row)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            mapList!.remove(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            if mapList!.count == 0 {
                mapList = loadSampleMaps()
                finishEditing()
            }
        } else if editingStyle == .Insert {
            let newMap = Map(title: "Untitled")
            mapList!.append(newMap)

        }
        saveMaps()
    }



    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        mapList!.swapItems(fromIndexPath.row, toIndexPath.row)
    }



    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier  == "MapDetailSegue") {
            if let mapViewController = segue.destinationViewController as? MapViewController {
                selectedMap = mapList!.get(tableView.indexPathForSelectedRow!.row)
                mapViewController.map = selectedMap
            }
        }
        
    }

    // MARK: - Editing
    func finishEditing() {
        self.tableView.setEditing(false, animated: true)
        saveMaps()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(MapListTableViewController.editMapList(_:)))
        tableView.reloadData()
    }
    
    func startEditing() {
        self.tableView.setEditing(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(MapListTableViewController.editMapList(_:)))
    }
    
    @IBAction func editMapList(sender: UIBarButtonItem) {
        if self.tableView.editing {
            finishEditing()
        } else {
            startEditing()
        }

    }
    @IBAction func addMap(sender: UIBarButtonItem) {
        let newMap = Map(title: "Untitled")
        mapList!.append(newMap)
        self.tableView.reloadData()
        
    }
    
    func loadSampleMaps() -> MapList {
        let openings = [
            Opening(.Small, .West),
            Opening(.Small, .North)
        ]
        let tile1 = Tile(openings: openings, imageName: "bend", backgroundImageName: "texture1", row: 0, column: 0)
        let tile2 = Tile(openings: openings, imageName: "bend", backgroundImageName: "texture1", row: 0, column: 1)
        let tile3 = Tile(openings: openings, imageName: "bend", backgroundImageName: "texture1", row: 1, column: 0)
        let tile4 = Tile(openings: openings, imageName: "bend", backgroundImageName: "texture1", row: 1, column: 1)
        tile1.rotate(.Clockwise)
        tile3.rotate(.Counterclockwise)
        tile4.rotate(.Clockwise)
        tile4.rotate(.Clockwise)
        let map1 = Map(title: "Sample Map 1", tiles:[tile1, tile2, tile3, tile4])
        let map2 = Map(title: "Sample Map 2", tiles:[tile1, tile2, tile3, tile4])
        return MapList(maps:[
            map1,
            map2
        ])
        
    }
    
    func loadMaps() -> MapList? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(MapList.ArchiveURL.path!) as? MapList
    }
    
    func saveMaps() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(mapList!, toFile: MapList.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save maps...")
        }
    }
    

}
