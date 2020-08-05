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
    private let transactionCollection = "transactions"
    private let ID = "id"
    typealias Transactions = [Transaction]
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
                self?.addUserInDatabase(user: user, completionHandler: { (success) in
                    completionHandler(success)
                })
                
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
            self?.getUserDetails(userID: uid, completionHandler: { (success) in
                completionHandler(success)
            })
            
        }
    }

    func addUserInDatabase(user: User, completionHandler:@escaping ((Bool) -> Void)) -> Bool {
        do {
            try database.collection(usersCollection).document(user.id).setData(from: user)// .addDocument(from: user)
            self.getUserDetails(userID: user.id) { (success) in
                completionHandler(true)
            }
            return true
        } catch let error {
            debugPrint(error.localizedDescription)
            return false
        }
        
    }
    
    func getUserDetails(userID: String, completionHandler: @escaping ((Bool) -> Void)) {
        database.collection(usersCollection).document(userID).getDocument { (document, error) in
            let result = Result {
              try document?.data(as: User.self)
            }
            switch result {
            case .success(let user):
                if let user = user {
                    print("User: \(user)")
                    UserManager.shared.userID = user.id
                    completionHandler(true)
                } else {
                    print("User does not exist")
                    completionHandler(false)
                }
            case .failure(let error):
                print("Error decoding user: \(error)")
                completionHandler(false)
            }
        }
    }
}

extension FirebaseDatabase: TransactionDB {
    func add(transaction: Transaction, completionHandler: @escaping ((Bool) -> Void)) {
        guard let userID = UserManager.shared.userID else {
            completionHandler(false)
            return
        }
        do {
            try database.collection(usersCollection).document(userID).collection(transactionCollection).addDocument(from: transaction)
            completionHandler(true)
            return
        } catch let error {
            debugPrint(error.localizedDescription)
            completionHandler(false)
            return
        }
    }
    
    func getAllTransaction(completionHandler: @escaping ((Transactions) -> Void)) {
        guard let userID = UserManager.shared.userID else {
            completionHandler([])
            return
        }
        database.collection(usersCollection).document(userID).collection(transactionCollection).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }
            var transactions: Transactions = []
            snapshot.documents.forEach({ (document) in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: .prettyPrinted)
                    let result = try JSONDecoder().decode(Transaction.self, from: jsonData)
                    transactions.append(result)
                } catch let error {
                    print("Error \(error.localizedDescription) on converting to generics: \(document.data())")
                }
            })
            completionHandler(transactions)
        }
    }
}
