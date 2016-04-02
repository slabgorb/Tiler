//
//  ImageItem.swift
//  Tiler
//
//  Created by Keith Avery on 4/1/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

class ImageItem {
    var name: String
    init(key:String, dataDictionary:Dictionary<String,String>) {
        self.name = dataDictionary[key]!
    }

    class func newImageItem(key: String, dataDictionary:Dictionary<String,String>) -> ImageItem {
        return ImageItem(key: key, dataDictionary: dataDictionary)
    }
}

