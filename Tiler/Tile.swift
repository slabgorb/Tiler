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

class Tile: Matchable, Rotatable, Flippable, CustomStringConvertible, Hashable, Equatable {
    static var current:Int = 0
 
    // MARK: Properties
    var openings: [Opening] = []
    var rotation: Direction = .North
    var imageName: String?
    var flippedVertically: Bool = false
    var flippedHorizontally: Bool = false
    var hashValue: Int  = {
        Tile.current += 1
        return Tile.current
    }()
    
    var description:String {
        var output:[String] = ["Tile Object #\(hashValue)"]
        output.append("Image: \(self.imageName)")
        output.append("Rotation: \(self.rotation) \(self.rotation.toDegrees())")
        output.append("Flipped Vertically: \(self.flippedVertically)")
        output.append("Flipped Horizontally: \(self.flippedHorizontally)")
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
    

    
    func rotate(direction: RotationDirection) -> Direction {
        var newOpenings: [Opening] = []
        for var opening in openings {
            opening.rotate(direction)
            newOpenings.append(opening)
        }
        self.openings = newOpenings
        self.rotation = self.rotation.rotate(direction)
        return self.rotation
        
     }
    
    
    func flip(transform: Transform) -> Void {
        switch transform {
        case .Vertical: self.flippedVertically = !self.flippedVertically
        case .Horizontal: self.flippedHorizontally = !self.flippedHorizontally
        }
        for opening in openings {
            opening.flip(transform)
        }
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
