//
//  Transaction.swift
//  Xpense
//
//  Created by Surjit on 02/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    var id: String?
    var currency: String?
    var amount: String?
    var name: String?
    var date: String?
    var category: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case currency
        case amount
        case name
        case date
        case category
    }
    
    
}
