//
//  UIButton+Flash.swift
//  Tiler
//
//  Created by Keith Avery on 4/9/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit


extension UIButton {
    func flash(color: UIColor) {
        let duration = 0.1
        let originalColor = backgroundColor
        UIView.animateWithDuration(duration, animations: {
            self.backgroundColor = color
            }, completion: { finished -> Void in
                UIView.animateWithDuration(duration) {
                    self.backgroundColor = originalColor
                }
        })
        
    }
}