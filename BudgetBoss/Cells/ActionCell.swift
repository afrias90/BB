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
    @IBOutlet weak var actionCellbgView: BattlegroundCellView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureActionCell(action: String) {
        //name of the action will
        if action == "Attack" {
            actionCellbgView.topColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            actionCellbgView.bottomColor = #colorLiteral(red: 0.4960200191, green: 0, blue: 0, alpha: 1)
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "Attack")
            actionDescriptLabel.text = "Priority expense? Strike first!"
        } else if action == "Defend" {
            actionCellbgView.topColor = #colorLiteral(red: 0.3804977238, green: 0.55394274, blue: 0.678417027, alpha: 1)
            actionCellbgView.bottomColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "Defense")
            actionDescriptLabel.text = "Ambushed by impulse buying? Defend yourself!"
        } else if action == "Smith" {
            actionCellbgView.topColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            actionCellbgView.bottomColor = #colorLiteral(red: 0.1579593122, green: 0.1015434489, blue: 0.06677952409, alpha: 1)
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "Upgrades")
            actionDescriptLabel.text = "Saving or putting money way? Smith away!"
        } else if action == "Cleanse" {
            actionCellbgView.topColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            actionCellbgView.bottomColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "Cleanse")
            actionDescriptLabel.text = "Paying down debt? Cleanse your curses here!"
        } else if action == "Sickness" {
            actionCellbgView.topColor = #colorLiteral(red: 0.9101042151, green: 0.8196988702, blue: 0, alpha: 1)
            actionCellbgView.bottomColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "sickness")
            actionDescriptLabel.text = "Fees? More debt?... Click here."
        } else if action == "Energy" {
            actionCellbgView.topColor = #colorLiteral(red: 0.3118339181, green: 0.3099858165, blue: 0.3132581413, alpha: 1)
            actionCellbgView.bottomColor = #colorLiteral(red: 0.06226360053, green: 0.5930793285, blue: 0.05658905953, alpha: 1)
            
            actionNameLabel.text = action
            actionImage.image = UIImage(named: "Energy")
            actionDescriptLabel.text = "Allowance? Penny on the street? Extra income? What luck!"
        }
        
        
    }

}
