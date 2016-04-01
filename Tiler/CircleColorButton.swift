//
//  CircleColorButton.swift
//  Tiler
//
//  Created by Keith Avery on 3/31/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

@IBDesignable class CircleColorButton: UIButton {

    @IBInspectable var color: UIColor = UIColor.redColor()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    override func awakeFromNib() {
        self.setup()
    }


    func setup() {
        self.layer.cornerRadius = CGFloat(self.frame.width / 2.0)
        self.layer.backgroundColor = self.color.CGColor
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setup()
    }
}
