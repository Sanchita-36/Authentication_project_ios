//
//  User.swift
//  Authentication
//
//  Created by Mac on 25/01/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation

class User{
    var uid: String = ""
    var email: String = ""
    var password: String = ""
    var name: String = ""
    var branch: String = ""
    var userType: String = ""

init() {
        
    }
init(data: [String: Any]) {
    self.uid = data["uid"] as? String ?? ""
    self.email = data["email"] as? String ?? ""
    self.password = data["password"] as? String ?? ""
    self.name = data["name"] as? String ?? ""
    self.branch = data["branch"] as? String ?? ""
    self.userType = data["userType"] as? String ?? ""
}
}
