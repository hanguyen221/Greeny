//
//  SideMenuRootController.swift
//  Greeny
//
//  Created by Ha Nguyen on 3/20/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class SideMenuRootController: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        navigationController?.navigationBar.isHidden = true
    }
}
