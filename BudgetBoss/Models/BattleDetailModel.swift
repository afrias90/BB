//
//  BattleDetailModel.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/5/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import Foundation

class BattleDetailModel {
    
    func calculateMathDetail(totalStamina: Double, staminaLeft: Double, damage: Double, targetName: String) -> (String, String, Double) {
        // damage/total stamina = percentage according to whole paycheck,
        // damage/staminaLeft = percentage according to paycheck left
        let percentOfTotal = (damage / totalStamina) * 100
        let percentOfRemaining = (damage / staminaLeft) * 100
        let newStamina = staminaLeft - damage
        
        var battleDetail1 = ""
        var battleDetail2 = ""
        
        //enermy toughness
        //to be added after Target appeared
        print("percentOfTotal:\(percentOfTotal)" )
        if percentOfTotal > 100 {
            battleDetail1 = "You feel the tremendous power eminating from \(targetName)."
        } else if percentOfTotal == 100 {
            battleDetail1 = "You face an opponent with an equal strength to you at 100%."
        } else if percentOfTotal > 90 {
            battleDetail1 = "\(targetName) moves right in front of you before you can even react."
        } else if percentOfTotal > 80 {
            battleDetail1 = "\(targetName) gives you a demonic stare."
        } else if percentOfTotal > 55 {
            battleDetail1 = "Be careful! Two hits from \(targetName) will knock you out!"
        } else if percentOfTotal > 50 {
            battleDetail1 = "A threat in disguise."
        } else if percentOfTotal > 25 {
            battleDetail1 = "More of a match than you thought."
        } else if percentOfTotal > 10 {
            battleDetail1 = "\(targetName) looks easy, but there may be more enemies around."
        } else if percentOfTotal > 5 {
            battleDetail1 = "Just the thing to relieve some stress."
        } else if percentOfTotal > 1 {
            battleDetail1 = "Just an everyday day goon."
        } else {
            battleDetail1 = "\(targetName) looks weak and pathetic."
        }
        
        //character fatigue
        //place at end.
        print("\(totalStamina)\(staminaLeft)\(newStamina)\(percentOfRemaining)")
        if percentOfRemaining > 100 {
            battleDetail2 = "You drop to the ground and pray that there is help coming."
        } else if percentOfRemaining == 100 {
            battleDetail2 = "\(targetName) is vanquished and you are left standing with all your power drained."
        } else if percentOfRemaining > 90 {
            battleDetail2 = "You are beyond exhausted and will feel the pain for days to come."
        } else if percentOfRemaining > 80 {
            battleDetail2 = "You clinch a close victory as \(targetName) falls right before you do. Don't worry... someone will find you"
        } else if percentOfRemaining > 55 {
            battleDetail2 = "You have some deep wounds. You might want to get that looked at... like right now."
        } else if percentOfRemaining > 45 {
            battleDetail2 = "You can't feel half of your face and your arm might be broken, but at least you're still moving..."
        } else if percentOfRemaining > 35 {
            battleDetail2 = "You took severe damage. You have cuts and bruises all over."
        } else if percentOfRemaining > 30 {
            battleDetail2 = "It would have been dangerous to drag this fight any longer"
        } else if percentOfRemaining > 25 {
            battleDetail2 = "You manage to conserve much of your strength, but keeping at this pace will wear you out quickly."
        } else if percentOfRemaining > 10 {
            battleDetail2 = "You can manage a few of these fights now and then, but don't go overboard."
        } else if percentOfRemaining > 5 {
            battleDetail2 = "You keep a cool head and take down \(targetName) with ease."
        } else if percentOfRemaining > 1 {
            battleDetail2 = "You let out a mighty laugh as you pounce the puny \(targetName)"
        } else {
            battleDetail2 = "Flexing your muscles, you walk away from an easy victory"
        }
        
        return (battleDetail1, battleDetail2, newStamina)
    }
    
    func calculateSmithDetail(totalStamina: Double, staminaLeft: Double, damage: Double, newItem: Bool) -> String {
        
        let percentOfTotal = (damage / totalStamina) * 100
        //let percentOfRemaining = (damage / staminaLeft) * 100
        //let newStamina = staminaLeft - damage
        
        var battleDetail1 = ""
        
        //strength of item
        if newItem {
            if percentOfTotal > 100 {
                battleDetail1 = "You meditate your hard earned energy to forge a weapon like no other."
            } else if percentOfTotal == 100 {
                battleDetail1 = "You face an opponent with an equal strength to you at 100%."
            } else if percentOfTotal > 90 {
                battleDetail1 = "You focus your energy forge a new weapon like no other."
            } else if percentOfTotal > 80 {
                battleDetail1 = "You meditate for a while to create a weapon of new calibur."
            } else if percentOfTotal > 55 {
                battleDetail1 = "You forge a powerful new weapon."
            } else if percentOfTotal > 50 {
                battleDetail1 = "You unleash over half of your stamina to create a new weapon. What could you be planning?"
            } else if percentOfTotal > 35 {
                battleDetail1 = "You sequester a well-sized portion of stamina for future use."
            } else if percentOfTotal >= 20 {
                battleDetail1 = "You focus your energy into a weapon for the future."
            } else if percentOfTotal > 10 {
                battleDetail1 = "You divert a small amount of energy to create another weapon. "
            } else if percentOfTotal > 5 {
                battleDetail1 = "You tap into your equipment's power to create a new weapon."
            } else if percentOfTotal > 1 {
                battleDetail1 = "You convert some of your equipment's energy into something for smaller fights."
            } else {
                battleDetail1 = "Congrats. You made... something"
            }
        } else {
            if percentOfTotal > 100 {
                battleDetail1 = "You focus an tremendous amount of power beyond your normal stamina to strengthen your weapon to high levels!"
            } else if percentOfTotal == 100 {
                battleDetail1 = "You focus all your stamina onto your weapon."
            } else if percentOfTotal > 90 {
                battleDetail1 = "You reach close to the the limits of your stamina to transfer almost all your power to your weapon."
            } else if percentOfTotal > 80 {
                battleDetail1 = "You focus hard to transfer a significant amount of power to your weapon."
            } else if percentOfTotal > 55 {
                battleDetail1 = "You replenish an enormous amount of power to your weapon."
            } else if percentOfTotal > 50 {
                battleDetail1 = "You meditate a long while to transfer a large portion of your stamina."
            } else if percentOfTotal >= 20 {
                battleDetail1 = "You transfer a great amount of power for the future."
            } else if percentOfTotal > 10 {
                battleDetail1 = "You transfer a good amount of power for future use."
            } else if percentOfTotal > 5 {
                battleDetail1 = "You replenish energy to your weapon"
            } else if percentOfTotal > 1 {
                battleDetail1 = "You transfer some energy to your weapon."
            } else {
                battleDetail1 = "You transfer a miniscule amount of power to your weapon."
            }
        }
        
        return battleDetail1
    }
   
    
    func calculateCleanseDetail (totalStamina: Double, damage: Double, originalDebt: Double, newDebt: Double) -> (String, String) {
        //new debt is after paying it down
        let percentOfTotal = (damage / totalStamina) * 100
        let percentOfTotalDebt = (newDebt / originalDebt) * 100
        var battleDetail1 = ""
        var battleDetail2 = ""
        
        if percentOfTotal > 100 {
            battleDetail1 = "You perform heavy meditation to cleanse your curse."
        } else if percentOfTotal == 100 {
            battleDetail1 = "You focus all your stamina to cleanse your curse."
        } else if percentOfTotal > 90 {
            battleDetail1 = "You rid yourself of the majority of your curse."
        } else if percentOfTotal > 80 {
            battleDetail1 = "You muster an enormous amount of power to cleanse your curse, but come short from eradicating it."
        } else if percentOfTotal > 55 {
            battleDetail1 = "You meditate for a while to cleanse over half of your curse."
        } else if percentOfTotal > 50 {
            battleDetail1 = "You perform a large cleanse."
        } else if percentOfTotal >= 20 {
            battleDetail1 = "You perform a medium cleanse."
        } else if percentOfTotal > 10 {
            battleDetail1 = "You cleanse some of your curse."
        } else if percentOfTotal > 5 {
            battleDetail1 = "You cleanse a small portion of your curse"
        } else if percentOfTotal > 1 {
            battleDetail1 = "You do a minimum to stop the spread of the curse."
        } else {
            battleDetail1 = "You sprinkle a few drops of power to cleanse your curse."
        }
        
        //we need debt to hold an original value for this...
        if percentOfTotalDebt < 100 {
            battleDetail2 = "The feel the curse thrash inside your body as its presense remains strong."
        } else if percentOfTotalDebt < 90 {
            battleDetail2 = "The curse continue to rage inside your body."
        } else if percentOfTotalDebt < 80 {
            battleDetail2 = "The curse remains strong."
        } else if percentOfTotalDebt < 55 {
            battleDetail2 = "You feel the curse less and less, but it will take more power to overcome."
        } else if percentOfTotalDebt < 50 {
            battleDetail2 = "The curse isn't as strong as it once was but you still feel its effects."
        } else if percentOfTotalDebt < 20 {
            battleDetail2 = "The curse lingers, but its power is not what it used to be."
        } else if percentOfTotalDebt < 10 {
            battleDetail2 = "The day you're free from the curse seems close."
        } else if percentOfTotalDebt < 5 {
            battleDetail2 = "The curse grows weaker."
        } else if percentOfTotalDebt < 1 {
            battleDetail2 = "The curse still lingers, but you feel yourself close to being free of it."
        } else if percentOfTotalDebt == 0 {
            battleDetail2 = "You feel free of a heavy weight as you eliminate the curse!"
        }
        
        
        return (battleDetail1, battleDetail2)
    
    }
    
    
    
    
    
    
    
    
    
    
}


