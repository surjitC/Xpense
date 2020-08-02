//
//  FirebaseDatabase.swift
//  Xpense
//
//  Created by Surjit on 24/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseDatabase {
    
    static let shared = FirebaseDatabase()
    private let database = Firestore.firestore()
    private let usersCollection = "users"
}

extension FirebaseDatabase: UserDB {
    func registration(usingUser user: User, completionHandler:@escaping ((Bool) -> Void)) {
        let email = user.email
        let password = user.password
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                completionHandler(false)
                return
            }
            if let result = result {
                let uid = result.user.uid
                var user = user
                user.id = uid
                let success = self?.addUserInDatabase(user: user) ?? false
                completionHandler(success)
                return
            }
            completionHandler(false)
        }
    }
    
    func authenticate(with email: String, and password: String, completionHandler: @escaping ((Bool) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                completionHandler(false)
                return
            }
            completionHandler(true)
        }
    }

    func addUserInDatabase(user: User) -> Bool {
        let result = try? database.collection(usersCollection).addDocument(from: user)
        if result?.documentID == nil {
            return false
        } else {
            return true
        }
    }
    
}
