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
    var needWater: Bool = true
    var waterNeed: Int = 0
    
    init(name: String, lat: Double, lng: Double, icon: UIImage? = UIImage(named: "ic_tree_green")!, needWater: Bool? = true, waterNeed: Int = 0) {
        super.init(name: name, lat: lat, lng: lng, icon: icon)
        self.needWater = needWater!
        self.waterNeed = waterNeed
        self.desc = "Cần \(waterNeed) lit nước"
    }
}
