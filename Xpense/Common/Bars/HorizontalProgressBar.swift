//
//  HorizontalProgressBar.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class HorizontalProgressBar: UIView {
    
    @IBInspectable var color: UIColor = .gray {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var gradientColor: UIColor = .white {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var progress: CGFloat = 0.4 {
        didSet { setNeedsDisplay() }
    }
    
    private let progressLayer = CALayer()
    private let gradientLayer = CAGradientLayer()
    private let backgroundMask = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
    }
    
    override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.5).cgPath
        layer.mask = backgroundMask
        UIView.animate(withDuration: 0.5) {
            let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * self.progress, height: rect.height))
            
            self.gradientLayer.frame = progressRect
            self.gradientLayer.colors = [self.color.cgColor, self.gradientColor.cgColor]
            self.gradientLayer.cornerRadius = rect.height * 0.5
        }
        
    }
}
