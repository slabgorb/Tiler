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
    
    @IBOutlet weak var editMapBarButton: UIBarButtonItem!
    @IBOutlet weak var addMapBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedMaps = loadMaps() {
            mapList = savedMaps
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            mapList!.remove(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            let newMap = Map(title: "Untitled")
            mapList!.append(newMap)

        }
        saveMaps()
    }



    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        mapList!.swapItems(fromIndexPath.row, toIndexPath.row)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func editMapList(sender: UIBarButtonItem) {
        if self.tableView.editing {
            self.tableView.setEditing(false, animated: true)
            saveMaps()
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editMapList:")
        } else {
            self.tableView.setEditing(true, animated: true)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "editMapList:")
        }

    }
    @IBAction func addMap(sender: UIBarButtonItem) {
        let newMap = Map(title: "Untitled")
        mapList!.append(newMap)
        self.tableView.reloadData()
        
    }
    
    func loadSampleMaps() -> MapList {
        return MapList(maps:[
            Map(title:"One"),
            Map(title:"Two")
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
