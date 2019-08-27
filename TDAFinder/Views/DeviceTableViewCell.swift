//
//  DeviceTableViewCell.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    var device: Device?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func layoutSubviews() {

        super.layoutSubviews()
        if let device = device {
            textLabel!.text = device.title
            detailTextLabel!.text = device.converter
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
