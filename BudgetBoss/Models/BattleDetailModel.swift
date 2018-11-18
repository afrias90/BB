//
//  BattleDetailModel.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/5/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import Foundation

class BattleDetailModel {
    
    func calculateMathDetail(totalStamina: Double, staminaLeft: Double, damage: Double) -> (String, String, Double) {
        // damage/total stamina = percentage according to whole paycheck,
        // damage/staminaLeft = percentage according to paycheck left
        let percentOfTotal = (damage / totalStamina) * 100
        let percentOfRemaining = (damage / staminaLeft) * 100
        let newStamina = staminaLeft - damage
        
        var battleDetail1 = ""
        var battleDetail2 = ""
        
        if percentOfTotal > 100 {
            battleDetail1 = "You stumble upon a powerful enemy. You sacrifice much to match its strength but is it worth it?"
        } else if percentOfTotal > 90 {
            battleDetail1 = " The enemy is powerful, requiring everything you have."
        } else if percentOfTotal > 80 {
            battleDetail1 = "You face a dangerous foe."
        } else if percentOfTotal > 55 {
            battleDetail1 = "You might be able to take this guy at full strength one on one."
        } else if percentOfTotal > 50 {
            battleDetail1 = "A threat in disguise."
        } else if percentOfTotal > 25 {
            battleDetail1 = "More of a match than you thought."
        } else if percentOfTotal > 10 {
            battleDetail1 = "Looks easy, but they are quick to surround."
        } else if percentOfTotal > 5 {
            battleDetail1 = "Just the enemy to relieve some stress."
        } else if percentOfTotal > 1 {
            battleDetail1 = "Every day goon."
        } else {
            battleDetail1 = "Did someone say something?"
        }
        
        if percentOfRemaining > 100 {
            battleDetail2 = "You drop to the ground and pray that there is help coming."
        } else if percentOfRemaining > 90 {
            battleDetail2 = "You are beyond exhausted and will feel the pain for days to come even if you manage to survive"
        } else if percentOfRemaining > 80 {
            battleDetail2 = "You clinch a close victory as the enemy falls right before you do. Don't worry... someone will find you"
        } else if percentOfRemaining > 55 {
            battleDetail2 = "You're not sure if you can stand but at least you're still breathing."
        } else if percentOfRemaining > 45 {
            battleDetail2 = "You have maybe one more fight like this left in you..."
        } else if percentOfRemaining > 25 {
            battleDetail2 = "You manage to conserve your strength, but keeping at this pace will wear you out."
        } else if percentOfRemaining > 10 {
            battleDetail2 = "You can manage a few of these fights now and then, but don't go overboard."
        } else if percentOfRemaining > 5 {
            battleDetail2 = "You keep a cool head and take down your opponent with ease."
        } else if percentOfRemaining > 1 {
            battleDetail2 = "You let out a mighty laugh as you pounce your puny target"
        } else {
            battleDetail2 = "Flexing your muscles, you walk away from an easy victory"
        }
        
        
        
        return (battleDetail1, battleDetail2, newStamina)
    }
    
}


