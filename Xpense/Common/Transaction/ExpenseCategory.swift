//
//  ExpenseCategory.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation

enum CategoryType: String, CaseIterable {
     case Food
     case Bills
     case Entertainment
     case Travel
     case Shopping
     case Miscellaneous
}

extension CategoryType {

    func getIndex() -> Int {
        return CategoryType.allCases.firstIndex(of: self)!
    }
    static func getCategory(for index: Int) -> CategoryType {
        return CategoryType.allCases[index]
    }
    
    static func getAllCategories() -> [CategoryType] {
        return CategoryType.allCases
    }
    static func getCategoryCount() -> Int {
        return CategoryType.allCases.count
    }
}
