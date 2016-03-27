//
//  Opening.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation


struct Opening: Matchable,  Flippable, CustomStringConvertible {
    var direction: Direction
    var size: Size
    var description: String {
        return String(format: "Direction: %10@ Size: %10@", arguments: [direction.rawValue, size.rawValue])
    }
    

    init(_ size: Size, _ direction: Direction) {
        self.size = size
        self.direction = direction
    }
    
    func matchSize(opening: Opening) -> Bool {
        return opening.size == self.size
    }
    
    mutating func rotate(direction: RotationDirection) -> Direction {
        self.direction = self.direction.rotate(direction)
        return self.direction
    }
    func flip(transform: Transform) -> Void {
        self.direction.flip(transform)
    }
    
    func matchWith(other:Opening) -> Bool {
        switch self.direction {
        case .North: return other.direction == .South && matchSize(other)
        case .South: return other.direction == .North && matchSize(other)
        case .East: return other.direction == .West && matchSize(other)
        case .West: return other.direction == .East && matchSize(other)
        }
    }

}
// MARK:- Property List Readable
extension Opening: PropertyListReadable  {
    
    func propertyListRepresentation() -> NSDictionary {
        let representation:[String:AnyObject] = [
            "size": self.size.rawValue,
            "direction": self.direction.rawValue,
        ]
        return representation
    }
    
    init?(propertyListRepresentation:NSDictionary?) {
        guard let values = propertyListRepresentation else { return nil }
        guard let sizeString = values["size"] as? String else { return nil }
        guard let directionString = values["direction"] as? String else { return nil }
        self.size = Size(rawValue: sizeString)!
        self.direction = Direction(rawValue: directionString)!
    }
}

