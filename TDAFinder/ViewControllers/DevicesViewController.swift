//
//  ViewController.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import UIKit
import RealmSwift

class DevicesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var devices: [Device]?

    override func viewDidLoad() {

        super.viewDidLoad()

        let realm = try! Realm()
        devices = Array(realm.objects(Device.self))
        // Do any additional setup after loading the view.

        tableView.tableFooterView = UIView()
    }
}


extension DevicesViewController: UITableViewDelegate {

}


extension DevicesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let devices = devices {
            return devices.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceTableViewCell", for: indexPath) as? DeviceTableViewCell, let devices = devices {
            cell.device = devices[indexPath.row]
            return cell
        }

        return UITableViewCell()
    }
}


extension DevicesViewController: UISearchBarDelegate {


}
