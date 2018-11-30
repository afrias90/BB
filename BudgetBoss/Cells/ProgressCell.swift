//
//  ProgressCell.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/28/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class ProgressCell: UITableViewCell {
    
    @IBOutlet weak var characterClassLabel: UILabel!
    @IBOutlet weak var periodDateLabel: UILabel!
    @IBOutlet weak var staminaInfoLabel: UILabel!
    @IBOutlet weak var staminaPointLabel: UILabel!
    @IBOutlet weak var attackInfoLabel: UILabel!
    @IBOutlet weak var attackPointLabel: UILabel!
    @IBOutlet weak var defenseInfoLabel: UILabel!
    @IBOutlet weak var defensePointLabel: UILabel!
    @IBOutlet weak var smithingInfoLabel: UILabel!
    @IBOutlet weak var smithingPointLabel: UILabel!
    @IBOutlet weak var cleanseInfoLabel: UILabel!
    @IBOutlet weak var cleansePointLabel: UILabel!
    @IBOutlet weak var sicknessInfoLabel: UILabel!
    @IBOutlet weak var sicknessPointLabel: UILabel!
    @IBOutlet weak var energyInfoLabel: UILabel!
    @IBOutlet weak var energyPointLabel: UILabel!
    @IBOutlet weak var totalProgressLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureProgressCell(character: Character, progress: Progress) {
        characterClassLabel.text = character.charClass
        //progress string needs to be assigned during save
        periodDateLabel.text = progress.period
        
        let stam = calcPercentAndPoints(total: progress.totalStamina, fraction: progress.stamina)
        
        staminaInfoLabel.text = progressString(ability: progress.stamina, total: progress.totalStamina, percent: stam.0)
        //staminaPointLabel.text = "\(stam.1)"
        
        let att = calcPercentAndPoints(total: progress.totalAttack, fraction: progress.attack)
        attackInfoLabel.text = progressString(ability: progress.attack, total: progress.totalAttack, percent: att.0)
        //attackPointLabel.text = "\(att.1)"
        
        let def = calcPercentAndPoints(total: progress.totalDefense, fraction: progress.defense)
        defenseInfoLabel.text = progressString(ability: progress.defense, total: progress.totalDefense, percent: def.0)
        //defensePointLabel.text = "\(def.1)"
        
        let smith = calcPercentAndPoints(total: progress.totalStamina, fraction: progress.smith)
        smithingInfoLabel.text = progressString2(ability: progress.smith, total: progress.totalStamina, percent: smith.0)
        let cleanse = calcPercentAndPoints(total: progress.totalStamina, fraction: progress.cleanse)
        cleanseInfoLabel.text = progressString2(ability: progress.cleanse, total: progress.totalStamina, percent: cleanse.0)
        let sickness = calcPercentAndPoints(total: progress.totalStamina, fraction: progress.sickness)
        sicknessInfoLabel.text = progressString2(ability: progress.sickness, total: progress.totalStamina, percent: sickness.0)
        let energy = calcPercentAndPoints(total: progress.totalStamina, fraction: progress.energy)
        energyInfoLabel.text = progressString2(ability: progress.energy, total: progress.totalStamina, percent: energy.0)
    
        totalProgressLabel.text = "Total Progress Points: \(progress.points)"
        
        
        
    }
    
    func calcPercentAndPoints(total: Double, fraction: Double) -> (Int, Int) {
        //fraction will be  'leftover = total - used'
        var percentage = 0
        if total == 0 {
            
        } else {
            percentage = Int((fraction / total) * 100)
        }
        let points = percentage / 10
        return (percentage, points)
    }
    
    func progressString(ability: Double, total: Double, percent: Int ) -> String {
        var abi = ability
        if total == 0 && ability < 0 {
            //if stamina/attack/def is not set, ability is negative
            abi = abs(abi)
            
        }
        
        let string = "\(abi) / \(total)(\(percent)%)"
        
        return string
        
    }
    
    func progressString2(ability: Double, total: Double, percent: Int ) -> String {
        let string = "\(ability) / \(total)(\(percent)% of stamina)"
        
        return string
        
    }

}
