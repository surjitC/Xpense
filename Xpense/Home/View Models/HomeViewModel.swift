//
//  HomeViewModel.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation

class HomeViewModel {

    enum Section: Int, CaseIterable {
        case Chart
        case Transaction
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
            return 5
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
}
