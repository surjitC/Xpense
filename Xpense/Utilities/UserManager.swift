//
//  UserManager.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    enum UserKeys: String {
        case userNameKey
        case userPasswordKey
    }
    
    var userName: String? {
        get {
            UserDefaults.standard.string(forKey: UserKeys.userNameKey.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserKeys.userNameKey.rawValue)
        }
    }
    
    var userPassword: String? {
        get {
            UserDefaults.standard.string(forKey: UserKeys.userPasswordKey.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserKeys.userPasswordKey.rawValue)
        }
    }
}
