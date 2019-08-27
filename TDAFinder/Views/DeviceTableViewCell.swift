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

    let gold = UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0, alpha: 1.0)
    let silver = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {

        super.layoutSubviews()
        if let device = device {
            backgroundColor = .darkGray
            textLabel!.text = device.title
            textLabel?.textColor = .white
            detailTextLabel!.text = device.converter
            detailTextLabel?.textColor = .white
            imageView?.image = nil
            if device.converter.contains("Single Crown") {
                textLabel?.textColor = silver
                imageView?.image = UIImage(named: "Crown")
            }
            if device.converter.contains("Double Crown") {
                textLabel?.textColor = gold
                imageView?.image = UIImage(named: "Crown")
            }
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
