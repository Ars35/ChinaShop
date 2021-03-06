//
//  UIViewExtension.swift
//  ChinaShop
//
//  Created by Arseniy Arseniev on 22.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var yEndPos: Int = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var xEndPos: Int = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: xEndPos, y: yEndPos)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    //    override func prepareForInterfaceBuilder() {
    //        layoutSubviews()
    //    }
    
}
