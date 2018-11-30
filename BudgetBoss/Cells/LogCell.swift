//
//  LogCell.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/4/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class LogCell: UITableViewCell {
    
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var logImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureLogCell(log: Log) {
        logTextView.text = log.detail
        if log.category == "Attack" {
            logImage.image = UIImage(named: "Attack")
        } else if log.category == "Defend" {
            logImage.image = UIImage(named: "Defense")
        } else if log.category == "Cleanse" {
            logImage.image = UIImage(named: "Cleanse")
        } else if log.category == "Smith" {
            logImage.image = UIImage(named: "Upgrades")
        } else if log.category == "Sickness" {
            logImage.image = UIImage(named: "sickness")
        } else if log.category == "Energy" {
            logImage.image = UIImage(named: "Energy")
        }
    }

}
