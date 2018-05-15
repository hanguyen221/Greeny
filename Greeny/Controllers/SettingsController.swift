//
//  SettingsController.swift
//  Greeny
//
//  Created by Ha Nguyen on 5/16/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class SettingsController: BaseController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let cellId = "cellId"
    
    var profileLabels: [String] = [
        "Name",
        "Username",
        "Email",
        "Phone number",
        "Address",
    ]
    var profileContents: [String] = [
        "Ha Nguyen",
        "hanguyen221",
        "hanguyen@gmail.com",
        "0962211665",
        "No 1 Dai Co Viet st"
    ]
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: view.bounds, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false
        tv.tableFooterView = UIView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Const.WHITE
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Cài đặt"
        
        view.addSubview(tableView)
        setupTableView()
        tableView.register(SettingsCell.self, forCellReuseIdentifier: cellId)
    }
    
    @objc func handleSave() {
        print("Saving...")
    }
    
    func setupTableView() {
        tableView.anchorWithConstraints(topAnchor: view.topAnchor,
                                        leftAnchor: view.leftAnchor,
                                        bottomAnchor: view.bottomAnchor,
                                        rightAnchor: view.rightAnchor)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingsCell
        cell.controller = self
        cell.contentTextField.delegate = self
        cell.profileLabel.text = profileLabels[indexPath.row]
        cell.contentTextField.text = profileContents[indexPath.row]
        if cell.contentTextField.text == "" {
            cell.contentTextField.placeholder = "Tap to add info"
        }
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

