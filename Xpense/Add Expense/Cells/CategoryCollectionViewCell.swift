//
//  CategoryCollectionViewCell.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var mainBackgroundView: UIView!
    
    lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainBackgroundViewTapped))
        return tap
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainBackgroundView.addShadow(radius: 8, cornerRadius: 8)
//        contentView.isUserInteractionEnabled = true
//        contentView.addGestureRecognizer(tap)
    }
    func configureCell(for category: CategoryType) {
        self.categoryNameLabel.text = category.rawValue
        self.categoryImageView.image = UIImage(named: category.rawValue)
    }
    
    @objc
    func mainBackgroundViewTapped() {
//        contentView.addCardPressAnimation { [weak self] success in
//            guard let self = self else { return }
//            UIView.animate(withDuration: 0.2) {
//                self.contentView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//            }
//        }
    }
}
