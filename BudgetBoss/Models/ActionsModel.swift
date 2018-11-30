//
//  ActionsModel.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/6/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import Foundation

class ActionModel {
    static let actionModel = ActionModel()
    //handle attack and defend.
    func checkFunds(equipment: Item, damage: Double) -> Bool {
        //passed over: equipment and damage
        //Defaults: stamina
        if (equipment.category == "asset" && equipment.value >= damage) || (equipment.category == "credit" && equipment.durability >= damage) {
            //determines if there are enough funds in the asset or credit
            return true
        } else {
            //equipment doesn't have enough funds
            return false
        }
        
    }
    func checkDebtPowerAsset(equipment: Item, affliction: Item, power: Double) -> Bool {
        //passed over: equipment, debt and damage
        //check that the power isn't more than the debt
        if power <= affliction.value {
            //then check that the equipment has enough power
            if equipment.value >= power {
                return true
            } else {
                //equipment doesn't have enough funds
                return false
            }
            
        }
        //power is greater than affliction -
        return false
    }
    
    ///////Logs
    func createLogForBudgetAction(equipment: Item, target: Merchant, move: Move, character: Character, damage: Double, action: String, bd1: String, bd2: String) -> Log {
        //budgetAction referse to Attack or Defend
        let log = Log(context: context)
        log.category = action
        log.date = Date()
        log.expense = true
        log.itemName = equipment.name
        //targetNewPower, target is not item so nothing
        log.power = damage
        log.itemNewPower = equipment.value
        log.targetName = target.name
        log.moveName = move.name
        
        
        //logDetail/story
        var attackOrDefend = ""
        if action == "Attack" {
            attackOrDefend = "strikes"
        } else {
            attackOrDefend = "defends"
        }
        
        let tName = target.name ?? "tName"
        let mName = move.name ?? "mName"
        let mActualName = move.actualName ?? "actual name missing"
        let cName = character.name ?? "cName"
        let eName = equipment.name ?? "eName"
        ///determine boss status
        
        log.detail = "\(tName) appeared. \(bd1) \(tName) uses \(mName) (\(mActualName)). \(cName) \(attackOrDefend) with \(eName) for \(damage) damage! \(bd2)"
        
        return log
    }
    
    func createLogForSmithAction(equipment: Item, secondary: Item, character: Character, damage: Double, newItem: Bool, action: String, bd1: String) -> Log {
        //budgetAction referse to Attack or Defend
        let log = Log(context: context)
        log.category = action
        log.moveName = "Smithing"
        log.date = Date()
        log.expense = false
        log.itemName = equipment.name
        log.itemNewPower = equipment.value
        //targetNewPower, target is not item so nothing
        log.power = damage
        log.targetName = secondary.name
        log.targetNewPower = secondary.value
        
        
        //logDetail/story
        
        let cName = character.name ?? "cName"
        let eName = equipment.name ?? "eName"
        let tName = secondary.name ?? "secondary item"
        var newOrOld = ""
        if newItem {
            newOrOld = "was created with"
        } else {
            newOrOld = "received"
        }
        
        
        log.detail = "\(cName) takes out \(eName). \(bd1) \(tName) \(newOrOld) \(damage) power!"
        
        return log
    }
    
    func createLogForCleanseAction(equipment: Item, secondary: Item, character: Character, damage: Double, action: String, bd1: String?, bd2: String?) -> Log {
        //budgetAction referse to Attack or Defend
        let log = Log(context: context)
        log.moveName = "Cleansing"
        log.category = action
        log.date = Date()
        log.expense = false
        log.itemName = equipment.name
        log.itemNewPower = equipment.value
        //targetNewPower, target is not item so nothing
        log.power = damage
        log.targetName = secondary.name
        log.targetNewPower = secondary.value
        
        
        //logDetail/story
        
        //let cName = character.name ?? "cName"
        //let eName = equipment.name ?? "eName"
        
        log.detail = "Cleanse detail not done."
        
        return log
    }
    func createLogForSickness(debt: Item, source: Merchant, damage: Double, action: String) -> Log {
        let log = Log(context: context)
        log.category = action
        log.date = Date()
        log.moveName = "Sickness"
        //don't remember rule on this
        log.expense = false
        log.itemName = debt.name
        log.itemNewPower = debt.value
        log.power = damage
        log.targetName = source.name
        
        
        
        return log
    }
    
    func createLogForEnergy(equipment: Item, source: Merchant, move: Move, damage: Double, action: String) -> Log {
        let log = Log(context: context)
        log.category = action
        log.moveName = "Energize"
        log.date = Date()
        //don't remember rule on this
        log.expense = false
        log.itemName = equipment.name
        log.itemNewPower = equipment.value
        log.power = damage
        log.targetName = source.name
        log.moveName = move.name
        
        
        
        return log
    }
    
    
    /// Fetches
    ////////Budget att/def
    func fetchPlayer() -> Character? {
        do {
            let results = try context.fetch(Character.fetchRequest()) as [Character]
            let character = results.first
            return character
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func fetchEquipment() -> [Item] {
        do {
            let results = try context.fetch(Item.fetchRequest()) as [Item]
            var equipment : [Item] = []
            if results.count > 0 {
                for item in results {
                    //credit, asset, debt
                    if item.category != "debt" {
                        equipment.append(item)
                        print("equipment added: \(equipment)")
                    } else {
                        // nothing
                    }
                }
                //return equipment if results is over 0
                return equipment
            } else {
                print("No equipment found. You're Naked!")
            }
            
        } catch {
            let error = error as NSError
            print(error)
        }
        // returns nothing
        return []
    }
    
    func fetchAssetEquipment() -> [Item] {
        do {
            let results = try context.fetch(Item.fetchRequest()) as [Item]
            var equipment : [Item] = []
            if results.count > 0 {
                for item in results {
                    //credit, asset, debt
                    //smithing purpose: cannot 'save money' from credit or debt
                    if item.category == "asset" {
                        equipment.append(item)
                        print("equipment added: \(equipment)")
                    } else {
                        // nothing
                    }
                }
                //return equipment if results is over 0
                return equipment
            } else {
                print("No equipment found. You're Naked!")
            }
            
        } catch {
            let error = error as NSError
            print(error)
        }
        // returns nothing
        return []
    }
    
    func fetchDebtEquipment() -> [Item] {
        //cleanse secondary
        do {
            let results = try context.fetch(Item.fetchRequest()) as [Item]
            var debt : [Item] = []
            if results.count > 0 {
                for item in results {
                    //credit, asset, debt
                    //smithing purpose: cannot 'save money' from credit or debt
                    if (item.category == "credit" && item.value > 0) || item.category == "debt" {
                        //credit can be debt but only if it has a value
                        debt.append(item)
                        print("equipment added: \(debt)")
                    } else {
                        // nothing
                    }
                }
                //return equipment if results is over 0
                return debt
            } else {
                print("No equipment found. You're Naked!")
            }
            
        } catch {
            let error = error as NSError
            print(error)
        }
        // returns nothing
        return []
    }
    
    
    func fetchTargets() -> [Merchant] {
        do {
            let results = try context.fetch(Merchant.fetchRequest()) as [Merchant]
            if results.count > 0 {
                return results
            }
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func fetchMoves() -> [Move] {
        do {
            let results = try context.fetch(Move.fetchRequest()) as [Move]
            if results.count > 0 {
                print("moves were found andfetched")
                return results
                
            }
        } catch let error as NSError {
            print(error)
        }
        print("no moves were found")
        return []
    }
    
    
    
    
    
    
    
    
    
}




