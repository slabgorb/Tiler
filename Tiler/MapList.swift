//
//  MapList.swift
//  Tiler
//
//  Created by Keith Avery on 3/27/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

class MapList:NSObject, NSCoding {
    var list:[Map] = []
    private let path = "SavedMaps"

    /**
     
     */
    
    
    init(maps:[Map]) {
        list = maps
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
    }
    

    
}