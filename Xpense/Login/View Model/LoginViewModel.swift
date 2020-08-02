//
//  LoginViewModel.swift
//  Xpense
//
//  Created by Surjit on 24/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation
protocol LoginViewModelProtocol: AnyObject {
    
    func createUser(using user: User)
    func authenticatedUser(with email: String, and password: String)
}
// MARK: - Singleton
class LoginViewModel {
    
    let database: UserDB
    var delegate: LoginViewControllerProtocol?
    init(database: UserDB = FirebaseDatabase.shared) {
        self.database = database
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    func createUser(using user: User) {
        self.database.registration(usingUser: user) { [weak self] (success) in
            self?.delegate?.completionHandler(success)
        }
        
    }
    
    func authenticatedUser(with email: String, and password: String) {
        self.database.authenticate(with: email, and: password) { [weak self] (success) in
            self?.delegate?.completionHandler(success)
        }
    }
    
    
}
