//
//  EmptyStateCollectionViewCell.swift
//  Xpense
//
//  Created by Surjit on 05/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit
import Lottie

class EmptyStateCollectionViewCell: UICollectionViewCell {

    static let identifier = "EmptyStateCollectionViewCell"
    
    @IBOutlet var animationContainerView: UIView!
    @IBOutlet var mainBackgroundView: UIView!
    
    var animationView: AnimationView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mainBackgroundView.addShadow()
    }
    
    func showLoading() {
        self.removeLoading()
        animationView = AnimationView()
        animationView?.animation = Animation.named(LottieEnum.FriesLoading.rawValue)
        animationView?.frame = animationContainerView.bounds
        animationContainerView.addSubview(animationView!)
        animationView?.loopMode = .loop
        animationView?.play()
    }
    
    func removeLoading() {
        self.animationView?.stop()
        self.animationView?.removeFromSuperview()
    }

}
