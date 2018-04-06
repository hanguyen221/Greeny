//
//  ModelTree.swift
//  Greeny
//
//  Created by Ha Nguyen on 4/6/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class ModelTree: ModelObject {
    var desc: String = ""
    
    init(name: String, lat: Double, lng: Double, desc: String, icon: UIImage? = UIImage(named: "ic_tree_green")!) {
        super.init(name: name, lat: lat, lng: lng, icon: icon)
        self.desc = desc
    }
}
