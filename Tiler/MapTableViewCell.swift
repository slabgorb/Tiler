//
//  MapTableViewCell.swift
//  Tiler
//
//  Created by Keith Avery on 3/26/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            
    }
    
    func loadItem(map:Map) {
        titleLabel.text = map.title
        detailLabel.text = map.details()
    }

}
