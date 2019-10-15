//
//  User.swift
//  CarsList
//
//  Created by MacBook Air on 13.10.2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import Firebase

struct User {
    var uid: String
    var email: String
    
    init(authData: Firebase.User) {
        self.uid = authData.uid
        self.email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
