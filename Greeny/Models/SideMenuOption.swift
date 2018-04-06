//
//  SideMenuOption.swift
//  Greeny
//
//  Created by Ha Nguyen on 3/21/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class SideMenuOption {
    var icon: UIImage = UIImage(named: "ic_settings")!
    var label: String = ""
    
    init(icon: UIImage, label: String) {
        self.icon = icon
        self.label = label
    }
}
