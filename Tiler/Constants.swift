//
//  Constants.swift
//  Tiler
//
//  Created by Keith Avery on 4/9/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    enum ColorName : UInt32 {
        case Translucent = 0xffffffcc
        case ButtonFlash = 0xD1DBBDff
        case TileSelectionsBackground = 0x91AA9D88
        case Background = 0xFCFFF5FF
        case SelectedTileBorder = 0xFFFFFFDD
        case DeselectedTileBorder = 0x193441DD
        case Overlay = 0xFFFFFF88
        case LightBorder = 0x19344188
//        $neutral_blue_1: #193441;
//        $neutral_blue_2: #3E606F;
//        $neutral_blue_3: #91AA9D;
//        $neutral_blue_4: #D1DBBD;
//        $neutral_blue_5: #FCFFF5;
    }
    
    convenience init(named name: ColorName) {
        let rgbaValue = name.rawValue
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

