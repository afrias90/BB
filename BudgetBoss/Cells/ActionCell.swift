//
//  ActionCell.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 10/31/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {
    
    
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var actionNameLabel: UILabel!
    @IBOutlet weak var actionDescriptLabel: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    func configureActionCell(action: String) {
        //name of the action will
        switch action {
        case "Attack":
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "Attack")
            actionDescriptLabel.text = "Expecting expense? Strike first!"
        case "Defend":
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "Defense")
            actionDescriptLabel.text = "Ambushed by delicious deals? Defend yourself!"
        case "Upgrade":
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "Upgrades")
            actionDescriptLabel.text = "Ah! What are you looking to make great?"
        case "Cleanse":
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "Cleanse")
            actionDescriptLabel.text = "Rid thy self of thy debt!"
        case "Sickness":
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "sickness")
            actionDescriptLabel.text = "More debt... Click here"
        case "Energy":
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "Energy")
            actionDescriptLabel.text = "Allowance? Penny on the street? What luck!"
        default:
            print("We aren't getting an action")
        }
        
        
    }

}
