//
//  ActionVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/1/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class ActionVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //variables
    var actionName: String?
    var targets: [Merchant] = []
    var moves: [Move] = []
    var equipment: [Item] = []
    var pickerChoice = ""
    var character: Character?
    
    //optionals that must be present to proceed
    var selectedEquipment: Item?
    var selectedTarget: Merchant?
    var selectedMove: Move?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerChoice == "equipment" {
            if equipment.isEmpty == false {
                return equipment.count
            } else {
                return 1
            }
        }
        if pickerChoice == "targets" {
            if targets.isEmpty == false {
                return targets.count
            } else {
                return 1
            }
        } else if pickerChoice == "moves" {
            if moves.isEmpty == false {
                return moves.count
            } else {
                return 1
            }
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("pickerchoice = \(pickerChoice)")
        if pickerChoice == "equipment" {
            if equipment.isEmpty == false {
                
                print("there is equipment")
                var equipmentNames: [String] = []
                for item in equipment {
                    let name = item.name
                    equipmentNames.append(name!)
                }
                print("equipment names \(equipmentNames)")
                return equipmentNames[row]
            }
        }
        if pickerChoice == "targets" {
            if targets.isEmpty == false {
                print("we have targets")
                var targetNames: [String] = []
                for target in targets {
                    let name = target.name
                    targetNames.append(name!)
                }
                return targetNames[row]
            }
        }
        
        if pickerChoice == "moves" {
            if moves.isEmpty == false {
                print("we have moves")
                var moveNames: [String] = []
                for move in moves {
                    let name = move.name
                    moveNames.append(name!)
                }
                return moveNames[row]
            }
        }
        
        
        //error
        return "Shut up"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerChoice == "equipment" {
            selectedEquipment = equipment[row]
            equippedItemName.textColor = UIColor.black
            equippedItemName.text = selectedEquipment?.name
            itemPowerLabel.text = String(format: "%0.2f", (selectedEquipment?.value)!)
            if selectedEquipment!.value < 0.0 {
                powerImage.image = UIImage(named: "Affliction")
            }
            if selectedEquipment!.category == "credit" {
                itemMagicLabel.text = String(format: "%0.2f", selectedEquipment!.durability)
            } else {
                itemMagicLabel.text = "NA"
            }
            
            
            pickerView.isHidden = true
        }
        
        if pickerChoice == "targets" {
            selectedTarget = targets[row]
            targetNameLabel.text = selectedTarget?.name
            pickerView.isHidden = true
        }
        if pickerChoice == "moves" {
            selectedMove = moves[row]
            objectNameLabel.text = selectedMove?.name
            pickerView.isHidden = true
        }
        
    }
    
    
    
    
    
    @IBOutlet weak var equipmentButton: UIButton!
    @IBOutlet weak var equippedItemName: UILabel!
    
    @IBOutlet weak var powerImage: UIImageView!
    @IBOutlet weak var itemPowerLabel: UILabel!
    @IBOutlet weak var magicImage: UIImageView!
    @IBOutlet weak var itemMagicLabel: UILabel!
    
    //target
    
    @IBOutlet weak var targetNameLabel: UITextField!
    @IBOutlet weak var targetAddButton: UIButton!
    @IBOutlet weak var objectNameLabel: UITextField!
    @IBOutlet weak var objectAddButton: UIButton!
    
    @IBOutlet weak var damageLabel: UITextField!
    
    //picker
    @IBOutlet weak var picker: UIPickerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.dataSource = self
        picker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if actionName != nil {
            title = actionName!
        }
        fetchEquipment()
        fetchTargets()
        fetchMoves()
        fetchPlayer()
        itemPowerLabel.text = "NA"
        itemMagicLabel.text = "NA"
    }
    
    
    @IBAction func equipItemTapped(_ sender: Any) {
        pickerChoice = "equipment"
        picker.reloadAllComponents()
        picker.isHidden = false
        equippedItemName.textColor = #colorLiteral(red: 0, green: 0.2883095741, blue: 0.6653674245, alpha: 1)
    }
    
    @IBAction func targetAddTapped(_ sender: Any) {
        pickerChoice = "targets"
        picker.reloadAllComponents()
        picker.isHidden = false
        
    }
    
    @IBAction func objectAddTapped(_ sender: Any) {
        //other name for objects, make a choice in the end
        pickerChoice = "moves"
        picker.reloadAllComponents()
        picker.isHidden = false
    }
    
    @IBAction func proceedTapped(_ sender: Any) {
        if selectedEquipment != nil && selectedTarget != nil && selectedMove != nil && damageLabel.text != "" {
            //initial check for all four parameters complete
            if selectedEquipment?.category == "credit" {
                //check to see that creditcard has enough durability or purchase would be declined
                //damagelabel should already be in the correct format
                if let damage = Double(damageLabel.text!) {
                    if (selectedEquipment?.durability)! >= damage {
                        
                    } else {
                        // show warning that there isn't enough credit
                    }
                }
                //if selectedEquipment?.durability
                
            } else if selectedEquipment?.category == "asset" {
                //do you have enough buying power?
                if let damage = Double(damageLabel.text!) {
                    if (selectedEquipment?.value)! >= damage {
                        //funds have gone through! Let's record
                        //Total stamina to calculate stuff
                        let totalStamina = UserDefaults.standard.double(forKey: "TotalStamina")
                        let staminaLeft = totalStamina - (character?.stamina)!
                        //stamina used
                        character?.stamina += damage
                        
                        
                        //The log!
                        let log = Log(context: context)
                        log.category = selectedEquipment?.category
                        log.date = Date()
                        log.expense = true
                        log.itemName = selectedEquipment?.name
                        log.targetNewPower = ((selectedEquipment?.value)! - damage)
                        log.power = damage
                        log.targetName = selectedTarget?.name
                        
                        var attackOrDefend = ""
                        if actionName == "Attack" {
                            attackOrDefend = "strikes"
                        } else {
                            attackOrDefend = "defends"
                        }
                        
                        let battleDetails = calculateMathDetail(totalStamina: totalStamina, staminaLeft: staminaLeft, damage: damage)
                        log.detail = "\(selectedTarget?.name ?? "") appeared. \(selectedTarget?.name ?? "") uses \(selectedMove?.name ?? "")(\(selectedMove?.actualName ?? ""). \(character?.name ?? "") \(attackOrDefend) with \(selectedEquipment?.name ?? "") for \(damage) damage! \(battleDetails.0 + battleDetails.1)"
                        
                        print("Summary: \(log.detail)")
                        
                        //need to incorporate the budgets
                        
                        ad.saveContext()
                    } else {
                        // show warning that there isn't enough buying power
                    }
                }
                
                
            } else {
                // error with equipment
            }
            
        } else {
            print("There is one or more parameters missing")
        }
    }
    
   
    
    func fetchEquipment() {
        do {
            
            //is it ok to have the context globally available like this? is not, what's safer? make it the instant you need it i believe..
            let results = try context.fetch(Item.fetchRequest()) as [Item]
            
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
               
            } else {
                print("No equipment found. You're Naked!")
            }
            
        } catch {
            let error = error as NSError
            print(error)
        }
    }
    
    
    //will need to add to these lists to test this out...
    func fetchTargets() {
        do {
            let results = try context.fetch(Merchant.fetchRequest()) as [Merchant]
            if results.count > 0 {
                targets = results
            }
        } catch let error as NSError {
            print(error)
        }
        
        
    }
    
    func fetchMoves() {
        do {
            let results = try context.fetch(Move.fetchRequest()) as [Move]
            if results.count > 0 {
                moves = results
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if targetNameLabel.text != "" {
            if selectedTarget != nil {
                //editing stopped, and there's something and a selected target
                if targetNameLabel.text != selectedTarget?.name {
                    //and they don't match
                    // copy name from text? if selected target is Nil, and don't create a new item?
                }
            } else {
                //no selected target
                //may just copy name from text
            }
        }
        
        if let text = Double(damageLabel.text!) {
            damageLabel.text = String(format: "%0.2f", text)
        } else {
            damageLabel.text = ""
        }
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if damageLabel.isFirstResponder {
            damageLabel.resignFirstResponder()
        }
        if objectNameLabel.isFirstResponder {
            objectNameLabel.resignFirstResponder()
        }
        if targetNameLabel.isFirstResponder {
            targetNameLabel.resignFirstResponder()
        }
        
        return true
    }
    
    func fetchPlayer() {
        do {
            let results = try context.fetch(Character.fetchRequest()) as [Character]
            character = results.first
            
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
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
