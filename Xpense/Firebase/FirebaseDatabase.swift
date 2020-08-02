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
    private let ID = "id"
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
            guard let uid = result?.user.uid else {
                completionHandler(false)
                return
            }
            self?.getUserDetails(userID: uid)
            completionHandler(true)
        }
    }

    func addUserInDatabase(user: User) -> Bool {
        do {
            try database.collection(usersCollection).document(user.id).setData(from: user)// .addDocument(from: user)
            self.getUserDetails(userID: user.id)
            return true
        } catch let error {
            debugPrint(error.localizedDescription)
            return false
        }
        
    }
    
    func getUserDetails(userID: String) {
        database.collection(usersCollection).document(userID).getDocument { (document, error) in
            let result = Result {
              try document?.data(as: User.self)
            }
            switch result {
            case .success(let user):
                if let user = user {
                    // A `User` value was successfully initialized from the DocumentSnapshot.
                    print("User: \(user)")
                    UserManager.shared.userID = user.id
                } else {
                    // A nil value was successfully initialized from the DocumentSnapshot,
                    // or the DocumentSnapshot was nil.
                    print("User does not exist")
                }
            case .failure(let error):
                // A `User` value could not be initialized from the DocumentSnapshot.
                print("Error decoding user: \(error)")
            }
        }
        
    }
    
}
