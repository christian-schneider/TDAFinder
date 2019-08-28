//
//  UIViewController+Extensions.swift
//  TDAFinder
//
//  Created by Christian Schneider on 28.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import UIKit

extension UIViewController {

    func setCustomBackButton(selector: Selector) {

        self.navigationItem.setHidesBackButton(true, animated:false)

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 40))
        let imageView = UIImageView(frame: CGRect(x: -10, y: 0, width: 20, height: 20))
        if let imgBackArrow = UIImage(named: "btn_back") {
            imageView.image = imgBackArrow
            view.addSubview(imageView)
            let backTap = UITapGestureRecognizer(target: self, action: selector)
            view.addGestureRecognizer(backTap)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 24).isActive = true
            view.widthAnchor.constraint(equalToConstant: 48).isActive = true
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
        }
    }
}
