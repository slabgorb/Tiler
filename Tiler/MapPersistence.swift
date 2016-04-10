//
//  MapPersistence.swift
//  Tiler
//
//  Created by Keith Avery on 4/10/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

protocol MapPersistence {
    var mapList: MapList? { get set }
}

extension MapPersistence {
    func loadMaps() -> MapList? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(MapList.ArchiveURL.path!) as? MapList
    }
    
    func saveMaps() {
        if let mapList = self.mapList {
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(mapList, toFile: MapList.ArchiveURL.path!)
            if !isSuccessfulSave {
                print("Failed to save maps...")
            }
        }
    }
}