//
//  TargetCell.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/4/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class TargetCell: UITableViewCell {
    
    @IBOutlet weak var targetNameLabel: UILabel!
    @IBOutlet weak var actualNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTargetCell(target: Merchant) {
        targetNameLabel.text = target.name
        actualNameLabel.text = target.actualName
    }

}
