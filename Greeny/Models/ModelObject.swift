//
//  ModelObject.swift
//  Greeny
//
//  Created by Ha Nguyen on 4/6/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class ModelObject {
    var name: String = ""
    var lat: Double = 0
    var lng: Double = 0
    var icon: UIImage?
    
    init(name: String, lat: Double, lng: Double, icon: UIImage?) {
        self.name = name
        self.lat = lat
        self.lng = lng
        self.icon = icon
    }
}
