//
//  HomeViewModel.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation
typealias DownloadComplete = ((Bool) -> Void)
class HomeViewModel {

    enum Section: Int, CaseIterable {
        case Chart
        case Transaction
    }

    var transactionViewModel: TransactionViewModel?
    var transactions: [Transaction] = []
    
    init(transactionViewModel: TransactionViewModel = TransactionViewModel()) {
        self.transactionViewModel = transactionViewModel
    }
    
    func getSection(for section: Int) -> Section? {
        return Section(rawValue: section)
    }
    func getSectionCount() -> Int {
        return Section.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        let sectionType = Section(rawValue: section)
        switch sectionType {
        case .Chart:
            return 1
        case .Transaction:
            return min(self.transactions.count, 3)
        default:
            return 0
        }
    }
    
    func getHeader(for section: Int) -> String? {
        let sectionType = Section(rawValue: section)
        switch sectionType {
        case .Chart:
            return "This Month Expense"
        case .Transaction:
            return "Recent Transactions"
        default:
            return ""
        }
    }
    
    func getAllTransactions(completionHandler:@escaping DownloadComplete) {
        self.transactionViewModel?.getTransaction(completion: { (transactions) in
            self.transactions = transactions
            completionHandler(true)
        })
    }
    
    func getAllTransactions(index: Int) -> Transaction {
        return transactions[index]
    }
}
