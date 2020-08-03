//
//  FirebaseProtocol.swift
//  Xpense
//
//  Created by Surjit on 24/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation

protocol UserDB {
    func registration(usingUser user: User, completionHandler:@escaping ((Bool) -> Void))
    func authenticate(with email: String, and password: String, completionHandler:@escaping ((Bool) -> Void))
}

protocol TransactionDB {
    func add(transaction: Transaction, completionHandler:@escaping ((Bool) -> Void))
    func getAllTransaction( completionHandler:@escaping (([Transaction]) -> Void))
}
