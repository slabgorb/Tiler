//
//  Opening.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation


class Opening: Matchable, Rotatable, Flippable, CustomStringConvertible {
    var direction: Direction
    var size: Size
    var door: Door?
    var description: String {
        return String(format: "Direction: %10@ Size: %10@", arguments: [direction.rawValue, size.rawValue])
    }
    
    
    init(_ size: Size, _ direction: Direction, door: Door) {
        self.size = size
        self.direction = direction
        self.door = door
    }
    init(_ size: Size, _ direction: Direction) {
        self.size = size
        self.direction = direction
        self.door = nil
    }
    
    func matchSize(opening: Opening) -> Bool {
        return opening.size == self.size
    }
    
    func rotate(direction: RotationDirection) -> Direction {
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
