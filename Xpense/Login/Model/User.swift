//
//  User.swift
//  Xpense
//
//  Created by Surjit on 24/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: String
    var firstname: String
    var lastname: String
    var email: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstname
        case lastname
        case email
        case password
    }
    
    init(id: String = UUID().uuidString,
         firstname: String,
         lastname: String,
         email: String,
         password: String) {
        
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
    }
}
