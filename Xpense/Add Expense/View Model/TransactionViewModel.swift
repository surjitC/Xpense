//
//  TransactionViewModel.swift
//  Xpense
//
//  Created by Surjit on 02/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation

class TransactionViewModel {
    
    var database: TransactionDB?
    var currentTransaction = Transaction()
    var selectedCategory: CategoryType?
    
    init(database: TransactionDB = FirebaseDatabase.shared) {
        self.database = database
    }
}

extension TransactionViewModel {
    func getTransaction(completion: @escaping ([Transaction]) -> Void) {
        database?.getAllTransaction(completionHandler: { transactions in
            completion(transactions)
        })
    }
    func addtransaction(completionHandler:@escaping ((Bool) -> Void)) {
        self.add(transaction: currentTransaction) { (success) in
            completionHandler(success)
        }
    }
    
    func add(transaction: Transaction, completionHandler:@escaping ((Bool) -> Void)) {
        database?.add(transaction: transaction, completionHandler: { success in
            completionHandler(success)
        })
    }
}
