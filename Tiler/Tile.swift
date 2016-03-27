//
//  Tile.swift
//  Tiler
//
//  Created by Keith Avery on 3/3/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation



class Tile: NSObject, Matchable, Rotatable, Flippable, NSCoding {
    static var current:Int = 0
 
    // MARK: Properties
    var openings: [Opening] = []
    var rotation: Direction = .North
    var imageName: String?
    var backgroundImageName: String?
    var flippedVertically: Bool = false
    var flippedHorizontally: Bool = false
    var row:Int32 = 0
    var column: Int32 = 0
    
    struct PropertyKey {
        static let imageNameKey = "imageName"
        static let backgroundImageNameKey = "backgroundImageName"
        static let rotationKey = "rotation"
        static let flippedVerticallyKey = "flippedVertically"
        static let flippedHorizontallyKey = "flippedHorizontally"
        static let openingsKey = "openings"
        static let rowKey = "row"
        static let columnKey = "column"
    }
    
    override var description:String {
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
    
    init(openings:[Opening], imageName: String?, backgroundImageName: String? ) {
        self.openings = openings
        self.imageName = imageName
        self.backgroundImageName = backgroundImageName
        super.init()
    }

    // MARK:- Serialize/Deserialize 
    required init?(coder aDecoder: NSCoder) {
        self.imageName = aDecoder.decodeObjectForKey(PropertyKey.imageNameKey) as? String
        self.backgroundImageName = aDecoder.decodeObjectForKey(PropertyKey.backgroundImageNameKey) as? String
        if let rotationDirectionString = aDecoder.decodeObjectForKey(PropertyKey.rotationKey) as? String {
            if let rotationDirection =  Direction(rawValue:rotationDirectionString) {
                self.rotation = rotationDirection
            }
        }
        self.flippedHorizontally = aDecoder.decodeBoolForKey(PropertyKey.flippedHorizontallyKey)
        self.flippedVertically = aDecoder.decodeBoolForKey(PropertyKey.flippedVerticallyKey)
        self.row = aDecoder.decodeIntForKey(PropertyKey.rowKey)
        self.column = aDecoder.decodeIntForKey(PropertyKey.columnKey)
        if let openingRawArray = aDecoder.decodeObjectForKey(PropertyKey.openingsKey) as? [NSDictionary] {
            self.openings = openingRawArray.map({Opening(propertyListRepresentation: $0)!})
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.rotation.rawValue, forKey: PropertyKey.rotationKey)
        aCoder.encodeBool(self.flippedHorizontally, forKey: PropertyKey.flippedHorizontallyKey)
        aCoder.encodeBool(self.flippedVertically, forKey: PropertyKey.flippedVerticallyKey)
        aCoder.encodeObject(self.imageName, forKey: PropertyKey.imageNameKey)
        aCoder.encodeObject(self.backgroundImageName, forKey: PropertyKey.backgroundImageNameKey)
        aCoder.encodeInt(self.row, forKey: PropertyKey.rowKey)
        aCoder.encodeInt(self.column, forKey: PropertyKey.columnKey)
        aCoder.encodeObject(openings.map({$0.propertyListRepresentation()}), forKey: PropertyKey.openingsKey)
        
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
