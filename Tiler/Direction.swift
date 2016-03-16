//
//  Direction.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation


enum Direction: String {
    case North =  "North"
    case East = "East"
    case South = "South"
    case West = "West"
    
    func toDegrees() -> Float {
        switch self {
        case .North: return 0.0
        case .East: return -90.0
        case .South: return -180.0
        case .West: return -270.0
        }
    }
    
    func flip(transform: Transform) {
        switch transform {
        case .Horizontal: flipHorizontal()
        case .Vertical: flipVertical()
        }
    }
    
    func flipHorizontal() -> Direction {
        switch self {
        case .North: return self
        case .South: return self
        case .East: return opposite()
        case .West: return opposite()
        }
    }
    func flipVertical() -> Direction {
        switch self {
        case .North: return opposite()
        case .South: return opposite()
        case .East: return self
        case .West: return self
        }
    }
    
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

