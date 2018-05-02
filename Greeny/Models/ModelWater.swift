//
//  ModelWater.swift
//  Greeny
//
//  Created by Ha Nguyen on 4/6/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class ModelWater: ModelObject {
    override init(name: String, lat: Double, lng: Double, icon: UIImage? = UIImage(named: "ic_water_resource")!) {
        super.init(name: name, lat: lat, lng: lng, icon: icon)
    }
}
