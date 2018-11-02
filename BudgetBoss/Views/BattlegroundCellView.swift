//
//  BattlegroundCellView.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/1/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
@IBDesignable

class BattlegroundCellView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
//        @IBInspectable var bgColor: CGColor = #colorLiteral(red: 0.5463244319, green: 0.6703535914, blue: 0.5557230115, alpha: 1) {
//            didSet {
//                self.layer.backgroundColor = bgColor
//            }
//        }
        @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1) {
            didSet {
                self.setNeedsLayout()
            }
        }
        @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1) {
            didSet {
                self.setNeedsLayout()
            }
        }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        //self.layer.backgroundColor = bgColor
    }
    
        override func layoutSubviews() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at: 0)
            self.clipsToBounds = true
        }

}
