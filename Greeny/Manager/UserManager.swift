//
//  UserManager.swift
//  Greeny
//
//  Created by Tung Nguyen on 5/15/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import Foundation

class UserManager: NSObject {
    
    private override init(){}
    
    static let instance = UserManager()
    
    static let users: [User] = [
        User(username: "laocong1", password: "1234", type: .worker),
        User(username: "laocong2", password: "123", type: .worker),
        User(username: "laocong3", password: "123456", type: .worker),
        User(username: "volunteer1", password: "1234", type: .volunteer),
        User(username: "volunteer2", password: "1234", type: .volunteer),
        User(username: "volunteer3", password: "1234", type: .volunteer),
        User(username: "volunteer4", password: "1234", type: .volunteer),
        User(username: "volunteer5", password: "1234", type: .volunteer)
    ]
    
}
