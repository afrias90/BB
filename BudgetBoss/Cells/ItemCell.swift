//
//  ItemCell.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/15/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
@IBDesignable

class ItemCell: UITableViewCell {
    
    
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
    
        override func layoutSubviews() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var actualName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    //green = asset, red = debt?
    @IBOutlet weak var valueLabel: UILabel!
    //durability
    @IBOutlet weak var magicImage: UIImageView!
    @IBOutlet weak var durabilityValue: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
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
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: Item) {
        nameLbl.text = item.name
        actualName.text = item.actualName ?? ""
        
        if item.category == "debt" {
            // value is negative = debt
            let value = item.value
            valueLabel.text = String(format: "%0.2f", value)
            categoryImage.image = UIImage(named: "Affliction")
            valueLabel.textColor = #colorLiteral(red: 0.7910651967, green: 0.0001520840534, blue: 0.1492383157, alpha: 1)
        }
        if item.category == "asset" {
            if item.value > 0 {
            categoryImage.image = UIImage(named: "Power Symbol")
            valueLabel.text = String(format: "%0.2f", item.value)
            valueLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            } else {
                let value = abs(item.value)
                valueLabel.text = String(format: "%0.2f", value)
                categoryImage.image = UIImage(named: "Affliction")
                valueLabel.textColor = #colorLiteral(red: 0.7910651967, green: 0.0001520840534, blue: 0.1492383157, alpha: 1)
            }
        }
        if item.category == "credit" {
            magicImage.isHidden = false
            durabilityValue.isHidden = false
            durabilityValue.text = String(format: "%0.2f",item.durability)
            if item.value == 0 {
                
                categoryImage.image = UIImage(named: "Power Symbol")
                valueLabel.text = String(format: "%0.2f", item.value)
                valueLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            } else {
                let value = abs(item.value)
                valueLabel.text = String(format: "%0.2f", value)
                categoryImage.image = UIImage(named: "Affliction")
                valueLabel.textColor = #colorLiteral(red: 0.7910651967, green: 0.0001520840534, blue: 0.1492383157, alpha: 1)
            }
        } else {
            magicImage.isHidden = true
            durabilityValue.isHidden = true
        }
    }
    
    
    

}
