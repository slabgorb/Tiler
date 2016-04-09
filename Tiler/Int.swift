//
//  Int.swift
//  Tiler
//
//  Created by Keith Avery on 4/6/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation


extension Int {
    func toRoman() -> String {
        return RomanNumeral.toRoman(self)
    }

}