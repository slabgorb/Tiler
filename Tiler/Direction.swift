//
//  Direction.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
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