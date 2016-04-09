//
//  MapList.swift
//  Tiler
//
//  Created by Keith Avery on 3/27/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

class MapList:NSObject, NSCoding {
    
    // MARK:- Properties
    var list:[Map] = []
    private let file:FileSaveHelper = FileSaveHelper(fileName: "Maps", fileExtension: .JSON)
    var count:Int {
        return list.count
    }
    
    // MARK:- Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("mapList")
    
    // MARK:- Initializers
    init(maps:[Map]) {
        list = maps
    }
    
    // MARK:- NSCoding
    required init?(coder aDecoder: NSCoder) {
        if let rawList = aDecoder.decodeObjectForKey("list") as? NSArray {
            self.list = rawList.map({$0 as! Map})
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(list, forKey:"list")
    }
    
    // MARK:- Methods
    func get(index:Int) -> Map {
        return list[index]
    }
    
    func append(map:Map) {
        list.append(map)
    }
    
    func remove(index:Int) {

        list.removeAtIndex(index)
    }
    
    func swapItems(from:Int, _ to:Int) {
        swap(&list[from], &list[to])
    }

}