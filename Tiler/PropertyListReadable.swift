//
//  PropertyListReadable.swift
//  Tiler
//
//  Created by Keith Avery on 3/27/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation
protocol PropertyListReadable {
    func propertyListRepresentation() -> NSDictionary
    init?(propertyListRepresentation:NSDictionary?)
}

func extractValuesFromPropertyListArray<T:PropertyListReadable>(propertyListArray:[AnyObject]?) -> [T] {
    guard let encodedArray = propertyListArray else {return []}
    return encodedArray.map{$0 as? NSDictionary}.flatMap{T(propertyListRepresentation:$0)}
}

func saveValuesToDefaults<T:PropertyListReadable>(newValues:[T], key:String) {
    let encodedValues = newValues.map{$0.propertyListRepresentation()}
    NSUserDefaults.standardUserDefaults().setObject(encodedValues, forKey:key)
}