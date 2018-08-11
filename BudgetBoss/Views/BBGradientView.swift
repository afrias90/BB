//
//  BBGradientView.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/11/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
@IBDesignable

class BBGradientView: UIView {

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
   
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
