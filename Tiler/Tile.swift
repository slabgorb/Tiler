//
//  Tile.swift
//  Tiler
//
//  Created by Keith Avery on 3/3/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation
enum Size: Int {
    case Small = 1, Medium, Large
}
enum Direction: Int {
    case North
    case East
    case South
    case West
    func opposite() -> Direction {
        switch self {
            case .North: return .South
            case .South: return .North
            case .East: return .West
            case .West: return .East
        }
    }
    func rotate(direction: RotationDirection) -> Direction {
        switch direction {
        case .Clockwise:
            switch self {
            case .North: return .East
            case .East: return .South
            case .South: return .West
            case .West: return .North
            }
        case .Counterclockwise:
            switch self {
            case .North: return .West
            case .East: return .North
            case .South: return .East
            case .West: return .South
            }
        }
    }
}

enum RotationDirection {
    case Clockwise, Counterclockwise
}

protocol Matchable {
    func matchWith(other: Self) -> Bool
}

protocol Rotatable {
    func rotate(direction: RotationDirection) -> Void
}

infix operator ~ {}
func ~<T: Matchable>(left: T, right: T) -> Bool {
    return left.matchWith(right)
}


struct Opening: Matchable {
    var direction: Direction
    var size: Size
    var door: Door?
    
    init(size: Size, _ direction: Direction, door: Door) {
        self.size = size
        self.direction = direction
        self.door = door
    }
    init(size: Size, _ direction: Direction) {
        self.size = size
        self.direction = direction
        self.door = nil
    }
   
    func matchSize(opening: Opening) -> Bool {
        return opening.size == self.size
    }
    
    mutating func rotate(direction: RotationDirection) -> Void {
        self.direction = self.direction.rotate(direction)
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

class Connection {
    var from: Tile
    var to: Tile
    var direction: Direction
    init(direction:Direction, from: Tile, to:Tile) {
        self.from = from
        self.to = to
        self.direction = direction
    }
}

class Tile: Matchable {
 
    var openings: [Opening] = []
    var connections: [Connection] = []
    var rotation: Direction = .North
 
    init(openings:[Opening]) {
        self.openings = openings
    }
    
    func isDeadEnd() -> Bool {
        return self.openings.count == 1
    }
    
    func rotate(direction: RotationDirection) -> Void {
        var newOpenings: [Opening] = []
        for var opening in openings {
            opening.rotate(direction)
            newOpenings.append(opening)
        }
        self.openings = newOpenings
        self.rotation = self.rotation.rotate(direction)
     }
    
    func connectedToDirection(direction: Direction) -> Bool {
        return connections.filter({$0.direction == direction}).count > 0
    }
    
    func isConnected() -> Bool {
        for opening in openings {
            if !connectedToDirection(opening.direction) {
                return false
            }
        }
        return true
    }
    
    func connectWith(tile:Tile, direction:Direction) -> Void {
        connections.append(Connection(direction: direction, from: self, to: tile))
        tile.connections.append(Connection(direction: direction.opposite(), from: tile, to: self))
    }
    
    func matchWith(other:Tile) -> Bool {
        for opening in self.openings {
            for matchingOpening in other.openings {
                if opening.matchWith(matchingOpening) {
                    return true
                }
            }
        }
        return false
        
    }
    
}
