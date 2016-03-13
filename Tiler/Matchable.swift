//
//  Matchable.swift
//  Tiler
//
//  Created by Keith Avery on 3/13/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

protocol Matchable {
    func matchWith(other: Self) -> Bool
}



infix operator ~ {}
func ~<T: Matchable>(left: T, right: T) -> Bool {
    return left.matchWith(right)
}