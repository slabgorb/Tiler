//
//  Tile.swift
//  Tiler
//
//  Created by Keith Avery on 3/3/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

class Tile: Matchable, CustomStringConvertible {
 
    // MARK: Properties
    var openings: [Opening] = []
    var connections: [Connection] = []
    var rotation: Direction = .North
    var imageName: String?
    
    var description:String {
        return "TILE\n\tRotation: \(self.rotation)\n\tImage: \(self.imageName)\n\tConnections:\(self.connections)"
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
