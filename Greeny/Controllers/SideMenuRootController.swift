//
//  SideMenuRootController.swift
//  Greeny
//
//  Created by Ha Nguyen on 3/20/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class SideMenuRootController: BaseController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(tableView)
        setupTableView()
    }
    
    func setupTableView() {
        tableView.anchorWithConstraints(topAnchor: view.topAnchor,
                                        leftAnchor: view.leftAnchor,
                                        bottomAnchor: view.bottomAnchor,
                                        rightAnchor: view.rightAnchor)
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SideMenuCell
        return cell
    }
}





