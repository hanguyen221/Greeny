//
//  User.swift
//  Greeny
//
//  Created by Tung Nguyen on 5/15/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import Foundation

public enum UserType {
    case worker
    case volunteer
}

class User {
    
    let username: String
    let password: String
    let type: UserType
    
    init(username: String, password: String, type: UserType = .worker) {
        self.username = username
        self.password = password
        self.type = type
    }
    
}
