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
    
    init(database: TransactionDB = FirebaseDatabase.shared) {
        self.database = database
    }
}

extension TransactionViewModel {
    func getTransaction() {
        database?.getAllTransaction(completionHandler: { _ in
            
        })
    }
    func addtransaction() {
        self.add(transaction: currentTransaction)
    }
    
    func add(transaction: Transaction) {
        database?.add(transaction: transaction, completionHandler: { success in
            
        })
    }
}
