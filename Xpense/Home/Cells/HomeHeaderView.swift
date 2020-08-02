//
//  HomeHeaderView.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit

class HomeHeaderView: UICollectionReusableView {
    
    static let identifier = "HomeHeaderView"
    
    var headerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6677469611, green: 0.6677629352, blue: 0.6677542925, alpha: 1)
        label.font = UIFont(name: "DIN Alternate", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        self.setupHeader()
     }

     required init(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)!
        self.setupHeader()
     }

    private func setupHeader() {
        self.backgroundColor = .white
        self.addSubview(self.headerNameLabel)
        self.headerNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.headerNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        
    }
    
    func configureHeader(with name: String?) {
        self.headerNameLabel.text = name
     }
}
