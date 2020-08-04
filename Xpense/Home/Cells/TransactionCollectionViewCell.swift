//
//  TransactionCollectionViewCell.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit

class TransactionCollectionViewCell: UICollectionViewCell {
    static let identifier = "TransactionCollectionViewCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var categoryImageView: UIImageView!
    
    func configureCell(_ transaction: Transaction) {
        self.nameLabel.text = transaction.name
        self.dateLabel.text = transaction.date?.getCompleteDate()?.formatDisplayDate()
        categoryImageView.image = UIImage(named: "fire")
        if let category = transaction.category {
            categoryImageView.image = UIImage(named: category)
        }
        guard let currency = transaction.currency, let amount = transaction.amount else { return }
        self.amountLabel.text = "\(currency) \(amount)"
    }
}
