//
//  ModelTree.swift
//  Greeny
//
//  Created by Ha Nguyen on 4/6/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class ModelTree: ModelObject {
    var type: Int = 0
    var totalWater: Double = 0
    var currentWater: Double = 0
    init(type: Int = 0, name: String, lat: Double, lng: Double, totalWater: Double, currentWater: Double) {
        super.init(name: name, lat: lat, lng: lng, icon: nil)
        self.type = type
        self.totalWater = totalWater
        self.currentWater = currentWater
        
        let waterNeed = totalWater - currentWater
        if waterNeed > 0 {
            if type == 0 {
                self.icon = UIImage(named: "ic_tree_red")
            } else if type >= 1 {
                self.icon = UIImage(named: "tree\(type)_red")
            }
        } else {
            if type == 0 {
                self.icon = UIImage(named: "ic_tree_green")
            } else if type >= 1 {
                self.icon = UIImage(named: "tree\(type)_green")
            }
        }
        
    }
}
