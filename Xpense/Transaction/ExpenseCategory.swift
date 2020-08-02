//
//  ExpenseCategory.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation

class ExpenseCategory {
    
    static let shared = ExpenseCategory()
    
    enum CategoryType: String, CaseIterable {
        case Food
        case Bills
        case Entertainment
        case Travel
        case Shopping
        case Miscellaneous
   }
    
    func getCategoryCount() -> Int {
        return CategoryType.allCases.count
    }
    
    func getCategory(for index: Int) -> CategoryType {
        return CategoryType.allCases[index]
    }
}
