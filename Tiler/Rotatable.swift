//
//  Rotatable.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

protocol Rotatable {
    func rotate(direction: RotationDirection) -> Direction
    
}