//
//  BackgroundItem.swift
//  Tiler
//
//  Created by Keith Avery on 3/31/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation
class BackgroundItem {

    var backgroundImage:String

    init(dataDictionary:Dictionary<String,String>) {
        backgroundImage = dataDictionary["backgroundImage"]!
    }

    class func newBackgroundItem(dataDictionary:Dictionary<String,String>) -> BackgroundItem {
        return BackgroundItem(dataDictionary: dataDictionary)
    }

}