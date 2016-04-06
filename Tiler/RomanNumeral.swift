//
//  RomanNumeral.swift
//  Tiler
//
//  Created by Keith Avery on 4/6/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation
enum RomanNumeral: Int, CustomStringConvertible {
    case M = 1000
    case CM = 900
    case D = 500
    case CD = 400
    case C = 100
    case XC = 90
    case L = 50
    case XL = 40
    case X = 10
    case IX = 9
    case V = 5
    case IV = 4
    case I = 1

    static var max:RomanNumeral = .M

    var successor: RomanNumeral? {
        switch self {
        case M: return .CM
        case CM: return .D
        case D: return .CD
        case CD: return .C
        case C: return .XC
        case XC: return .L
        case L: return .XL
        case XL: return .X
        case X: return .IX
        case IX: return .V
        case V: return .IV
        case IV: return .I
        case I: return nil
        }
    }

    var description: String {
        switch self {
        case M: return "M"
        case CM: return "CM"
        case D: return "D"
        case CD: return "CD"
        case C: return "C"
        case XC: return "XC"
        case L: return "L"
        case XL: return "XL"
        case X: return "X"
        case IX: return "IX"
        case V: return "V"
        case IV: return "IV"
        case I: return "I"
        }
    }
    static func toRoman(value: Int) -> String {
        var roman:RomanNumeral?
        roman = RomanNumeral.max
        var result = ""
        var arabic = value
        while roman != nil {
            if arabic >= roman!.rawValue {
                result += roman!.description
                arabic -= roman!.rawValue
            }
            if arabic < roman!.rawValue {
                roman = roman!.successor
            }
        }
        return result

    }
}
