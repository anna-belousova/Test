//
//  User.swift
//  CarsList
//
//  Created by MacBook Air on 20.10.2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import Firebase

struct User {
    let uid: String
    let email: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
