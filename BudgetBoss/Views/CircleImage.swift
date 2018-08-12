//
//  CircleImage.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/11/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
@IBDesignable

class CircleImage: UIImageView {
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
   
}
