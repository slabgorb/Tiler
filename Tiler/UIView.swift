//
//  UIView.swift
//  Tiler
//
//  Created by Keith Avery on 3/24/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit
extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}