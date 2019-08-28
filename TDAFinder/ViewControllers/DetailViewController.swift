//
//  DetailViewController.swift
//  TDAFinder
//
//  Created by Christian Schneider on 28.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var device: Device?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var converterLabel: UILabel!
    @IBOutlet weak var mechanismLabel: UILabel!

    @IBOutlet weak var searchOnEbayButton: UIButton!
    @IBOutlet weak var searchGoogleImagesButton: UIButton!

    override func viewDidLoad() {

        super.viewDidLoad()

        device = store.state.detailState.device

        let right = UISwipeGestureRecognizer(target : self, action : #selector(goBack))
        right.direction = .right
        view.addGestureRecognizer(right)

        view.backgroundColor = .darkGray
        setCustomBackButton(selector: #selector(goBack))
        if let device = device {
            titleLabel.text = device.title
            converterLabel.text = device.converter
            mechanismLabel.text = device.mechanism
        }
    }

    @objc func goBack() {
        store.dispatch(RoutingAction(destination: .devices, isPop: true))
    }


    @IBAction func searchOnEbay() {

        if let device = device {
            let urlString = "https://www.ebay.com/sch/?_nkw=\(device.title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
            print(urlString)
            guard let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url)
        }

    }


    @IBAction func searchGoogleImages() {

        if let device = device {
            let urlString = "https://www.google.com/search?tbm=isch&q=\(device.title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
            print(urlString)
            guard let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url)
        }
    }

}
