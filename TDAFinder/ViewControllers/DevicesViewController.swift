//
//  ViewController.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import UIKit
import RealmSwift
import ReSwift


class DevicesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var searchString: String = ""

    var filteredDevices: [Device]?

    override func viewDidLoad() {

        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        segmentedControl.tintColor = .lightGray
        tableView.backgroundColor = .darkGray
        navigationController?.navigationBar.backgroundColor = .darkGray
        view.backgroundColor = .darkGray

        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for: .valueChanged)
    }


    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        store.subscribe(self) {
            $0.select {
                $0.devicesState
            }
        }
        reloadFilteredDevices()
    }


    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }


    @objc func segmentedControlValueChanged(segment: UISegmentedControl) {

        reloadFilteredDevices()
    }


    func reloadFilteredDevices() {

        let realm = try! Realm()
        if searchString == "" {
            if segmentedControl.selectedSegmentIndex > 0 {
                let crownString = segmentedControl.selectedSegmentIndex == 1 ? "Single Crown" : "Double Crown"
                let query = String(format: " converter CONTAINS[c] \"%@\" ", crownString)
                filteredDevices = Array(realm.objects(Device.self).filter(query))
            }
            else {
                filteredDevices = Array(realm.objects(Device.self))
            }
        }
        else {

            var query = ""
            query.append(" ( ")
            for substr in searchString.split(separator: " ") {
                query.append(String(format: " title CONTAINS[c] \"%@\" AND ", String(substr)))
            }
            query = query.replacingLastOccurrenceOfString("AND", with: "")
            query.append(" ) ")

            if segmentedControl.selectedSegmentIndex > 0 {
                let crownString = segmentedControl.selectedSegmentIndex == 1 ? "Single Crown" : "Double Crown"
                query.append(String(format: " AND converter CONTAINS[c] \"%@\" ", crownString))
            }

            filteredDevices = Array(realm.objects(Device.self).filter(query))
        }
        tableView.reloadData()
    }
    
}


extension DevicesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let devices = filteredDevices {
            let device = devices[indexPath.row]
            print("show details for device: \(device)")
        }
        //
    }

}


extension DevicesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let devices = filteredDevices {
            return devices.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceTableViewCell", for: indexPath) as? DeviceTableViewCell, let devices = filteredDevices {
            cell.device = devices[indexPath.row]
            return cell
        }

        return UITableViewCell()
    }
}


extension DevicesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        store.dispatch(SearchAction(searchString: searchText))
    }
}


// MARK: - StoreSubscriber

extension DevicesViewController: StoreSubscriber {

    func newState(state: DevicesState) {

        if state.searchString != searchString {
            searchString = state.searchString.trimmingCharacters(in: .whitespaces)
            reloadFilteredDevices()
        }
    }
}
