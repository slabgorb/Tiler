//
//  Tile.swift
//  Tiler
//
//  Created by Keith Avery on 3/3/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

func ==(lhs: Tile, rhs: Tile) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}

class Tile: Matchable, CustomStringConvertible, Hashable, Equatable {
    static var current:Int = 0
 
    // MARK: Properties
    var openings: [Opening] = []
    var connections: [Connection] = []
    var rotation: Direction = .North
    var imageName: String?
    var flippedVertically: Bool = false
    var flippedHorizontally: Bool = false
    var hashValue: Int  = {
        Tile.current += 1
        return Tile.current
    }()
    
    var description:String {
        var output:[String] = ["Tile Object"]
        output.append("Image: \(self.imageName)")
        output.append("Rotation: \(self.rotation) \(self.rotation.toDegrees())")
        output.append("Flipped Vertically: \(self.flippedVertically)")
        output.append("Flipped Horizontally: \(self.flippedHorizontally)")
        output.append("Connections: \(self.connections.count)")
        for connection in connections {
            output.append("\t\(connection.description)")
        }
        output.append("Openings: \(self.openings.count)")
        for opening in openings {
            output.append("\t\(opening.description)")
        }
        return output.joinWithSeparator("\n\t")
    }
    
    var isDeadEnd:Bool {
        return self.openings.count == 1
    }
 
    // MARK: Initializers
    
    init(openings:[Opening], imageName: String = "") {
        self.openings = openings
        self.imageName = imageName
    }

    // MARK: Methods
    

    
    func rotate(direction: RotationDirection) -> Void {
        for opening in openings {
            opening.rotate(direction)
        }
        self.rotation = self.rotation.rotate(direction)
     }
    
    func connectedToDirection(direction: Direction) -> Bool {
        return connections.filter({$0.direction == direction}).count > 0
    }
    
    func flip(transform: Transform) {
        switch transform {
        case .Vertical: self.flippedVertically = !self.flippedVertically
        case .Horizontal: self.flippedHorizontally = !self.flippedHorizontally
        }
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
