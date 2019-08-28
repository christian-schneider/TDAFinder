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

        view.backgroundColor = .darkGray

        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .darkGray

        segmentedControl.tintColor = .lightGray
        segmentedControl.layer.borderColor = UIColor.darkGray.cgColor
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for: .valueChanged)

        searchBar.barTintColor = .darkGray
        searchBar.returnKeyType = .done

        self.title = "TDAFinder"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }


    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        store.subscribe(self) {
            $0.select {
                $0.devicesState
            }
        }
        reloadFilteredDevices()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }


    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        store.unsubscribe(self)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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


    @objc func keyboardWillShow(_ notification: Notification) {

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue

            var contentInsets:UIEdgeInsets
            if UIDevice.current.orientation.isPortrait {
                contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardRectangle.height, right: 0.0);
            }
            else {
                contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardRectangle.width, right: 0.0);
            }
            tableView.contentInset = contentInsets
        }
    }


    @objc func keyboardWillHide(_ notification: Notification) {

        tableView.contentInset = .zero
    }
}


extension DevicesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let devices = filteredDevices {
            let device = devices[indexPath.row]
            store.dispatch(SelectDetailAction(device: device))
            store.dispatch(RoutingAction(destination: .detail))
        }
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


    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {

        searchBar.resignFirstResponder()
        return true
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
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
