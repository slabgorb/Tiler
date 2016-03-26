//
//  MapControlsView.swift
//  Tiler
//
//  Created by Keith Avery on 3/24/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

@IBDesignable class MapControlsView: UIView {
    // MARK: Properties
    @IBOutlet weak var textMapName: UITextField!
    @IBOutlet weak var labelRow: UILabel!
    @IBOutlet weak var labelColumn: UILabel!
    @IBOutlet weak var stepperRow: UIStepper!
    @IBOutlet weak var stepperColumn: UIStepper!
    @IBOutlet weak var buttonMapName: UIButton!
    @IBOutlet weak var buttonOK: UIButton!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    // MARK: Actions
    @IBAction func actionMapNameEditingDidEnd(sender: UITextField) {
        textMapName.hidden = true
        buttonMapName.hidden = false
    }

    @IBAction func actionOK(sender: UIButton) {
        textMapName.endEditing(true)
    }

    
    @IBAction func actionMapNameChanged(sender: UITextField) {
        //mapView.map.title = sender.text
        buttonMapName.setTitle(sender.text, forState: .Normal)
    }

    @IBAction func stepperRowChange(sender: UIStepper) {
        labelRow.text = String(Int(sender.value))
    }

    @IBAction func stepperColumnChange(sender: UIStepper) {
        labelColumn.text = String(Int(sender.value))
    }

    override init(frame: CGRect) {

        super.init(frame: frame)
        xibSetup()
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setup()
    }

    func setup() {
        self.stepperColumn.value = 1.0
        self.stepperRow.value = 1.0
        textMapName.hidden = true
    }

    // Our custom view from the XIB file

    func xibSetup() {
        var view: UIView!
        view = UIView.loadFromNibNamed("MapControls", bundle: NSBundle(forClass: self.dynamicType))
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }

}
