//
//  Utilities.swift
//  Xpense
//
//  Created by Surjit on 23/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit
import Lottie

var spinner: AnimationView?
var emptyView: UIView?

extension UITextField {
    func addDepth() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.white.cgColor
        self.borderStyle = .roundedRect
    }
}

extension UIButton {
    func makecoloredButton() {
        self.layer.shadowColor = #colorLiteral(red: 0.3699039817, green: 0.7330554724, blue: 0.9979006648, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 10
    }
    
    func makeCircularButton() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
    }
}

extension UIViewController {
    func showSpinner(on view: UIView, type: LottieEnum = .ElephantLoading) {
        let animationView = AnimationView()
        animationView.animation = Animation.named(type.rawValue)
        animationView.play()
        emptyView = UIView()
        emptyView?.frame = view.frame
        view.addSubview(emptyView!)
        emptyView?.backgroundColor = .white
        spinner = animationView
        spinner?.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        emptyView?.addSubview(spinner!)
        spinner?.center = view.center
        spinner?.loopMode = .loop
        spinner?.play()
        
    }
    
    func removeSpinner() {
        spinner?.stop()
        emptyView?.removeFromSuperview()
        spinner?.removeFromSuperview()
    }
}

extension UIView {
    func addShadow(color: UIColor = .darkGray, radius: CGFloat = 6, offset: CGSize = .zero, opacity: Float = 0.5, cornerRadius: CGFloat = 16) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.cornerRadius = cornerRadius
    }
    
    func addCardPressAnimation(completionHandler:@escaping ((Bool) -> Void)) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.transform = .identity
                completionHandler(true)
            }, completion: nil)
        }
    }
}
