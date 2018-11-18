//
//  ActionVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/12/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class ActionVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var actionName: String!
    var character: Character!
    
    var targets: [Merchant] = []
    var moves: [Move] = []
    var equipment: [Item] = []
    var secondaryEquipment: [Item] = []
    var pickerChoice = ""
    
    var selectedEquipment: Item?
    var selectedSecondary: Item?
    var selectedTarget: Merchant?
    var selectedMove: Move?
    
    ////outlets
    //1stItemView
    @IBOutlet weak var item1TF: UITextField!
    @IBOutlet weak var item1Label: UILabel!
    @IBOutlet weak var item1Button: UIButton!
    @IBOutlet weak var itemImage1: UIImageView!
    @IBOutlet weak var valueLabel1: UILabel!
    @IBOutlet weak var magicImage1: UIImageView!
    @IBOutlet weak var magicLabel1: UILabel!
    //2ndItemView
    @IBOutlet weak var item2TF: UITextField!
    @IBOutlet weak var item2Label: UILabel!
    @IBOutlet weak var item2Button: UIButton!
    @IBOutlet weak var itemImage2: UIImageView!
    @IBOutlet weak var valueLabel2: UILabel!
    @IBOutlet weak var magicImage2: UIImageView!
    @IBOutlet weak var magicLabel2: UILabel!
    //input1View
    @IBOutlet weak var input1TF: UITextField!
    @IBOutlet weak var input1Button: UIButton!
    //input2View
    @IBOutlet weak var input2TF: UITextField!
    @IBOutlet weak var input2Button: UIButton!
    
    //power or damage
    @IBOutlet weak var damagePowerLabel: UILabel!
    @IBOutlet weak var powerInputTF: UITextField!
    //picker
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var proceedButton: UIButton!
    
    //constraints
    @IBOutlet weak var item1TFWidth: NSLayoutConstraint!
    @IBOutlet weak var item1LabelWidth: NSLayoutConstraint!
    @IBOutlet weak var item2TFWidth: NSLayoutConstraint!
    @IBOutlet weak var item2LabelWidth: NSLayoutConstraint!
    
    //1stItemView is always present
    //secondItemViewHeight height @ 80
    @IBOutlet weak var secondItemViewHeight: NSLayoutConstraint!
    //secondItemViewHeight top @ 1
    @IBOutlet weak var secondItemViewTop: NSLayoutConstraint!
    //input1ViewHeight @ 70
    @IBOutlet weak var input1ViewHeight: NSLayoutConstraint!
    @IBOutlet weak var input1ViewTop: NSLayoutConstraint!
    //input2View
    @IBOutlet weak var input2ViewHeight: NSLayoutConstraint!
    @IBOutlet weak var input2ViewTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self

        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ActionVC.closeTap(_:)))
        view.addGestureRecognizer(closeTouch)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if actionName != nil {
            title = actionName!
            //setup the views for specific action
            actionSetup()
            
        } else {
            title = "error"
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    ////
    ////
    //actionSetup
    func actionSetup() {
        //character always needed
        fetchPlayer()
        if actionName == "Attack" || actionName == "Defend" {
            secondItemViewHeight.constant = 0
            secondItemViewTop.constant = 0
            item1Label.text = "Equipment"
            input1TF.text = "Target"
            input2TF.text = "Move"
            damagePowerLabel.text = "Damage:"
            
            if actionName == "Attack" {
                proceedButton.setImage(UIImage(named: "Attack"), for: .normal)
            } else {
                proceedButton.setImage(UIImage(named: "Defense"), for: .normal)
            }
            //fetches here
            
            fetchEquipment()
            fetchTargets()
            fetchMoves()
            
        }
        if actionName == "Smith" {
            //both items
            // 2nd item should have TF instead of label
            item2TFWidth.constant = item2LabelWidth.constant
            item2LabelWidth.constant = 0
            
            input1ViewHeight.constant = 0
            input1ViewTop.constant = 0
            input2ViewHeight.constant = 0
            input2ViewTop.constant = 0
            
            proceedButton.setImage(UIImage(named: "Upgrades"), for: .normal)
            item1Label.text = "Equipment"
            //disable item2 until power source/item1 is selected
            item2Button.isEnabled = false
            item2TF.isEnabled = false
            item2TF.text = "Select equipment"
            damagePowerLabel.text = "Power Tansfer:"
            
            //will fetch assets only
            fetchAssetEquipment()
            
            //will need another item list that removes equipment selected as potential second item
        }
        
        if actionName == "Cleanse" {
            
            input1ViewHeight.constant = 0
            input1ViewTop.constant = 0
            input2ViewHeight.constant = 0
            input2ViewTop.constant = 0
            proceedButton.setImage(UIImage(named: "Cleanse"), for: .normal)
            //fetches and add debt, including credit
            fetchAssetEquipment()
            fetchDebtEquipment()
            
            item1Label.text = "Equipment"
            item2Label.text = "Affliction"
            damagePowerLabel.text = "Power:"
            itemImage2.image = UIImage(named: "Affliction")
            
        }
        if actionName == "Sickness" {
            item1TFWidth.constant = item1LabelWidth.constant
            item1LabelWidth.constant = 0
            
            secondItemViewHeight.constant = 0
            secondItemViewTop.constant = 0
            //input1ViewHeight.constant = 0
            //input1ViewTop.constant = 0
            input2ViewHeight.constant = 0
            input2ViewTop.constant = 0
            
            item1TF.placeholder = "New debt?"
            input1TF.placeholder = "Source (ex. Loan company)"
            damagePowerLabel.text = "Affliction:"
            itemImage1.image = UIImage(named: "Affliction")
            
            equipment = ActionModel.actionModel.fetchDebtEquipment()
            fetchTargets()
            
            proceedButton.setImage(UIImage(named: "sickness"), for: .normal)
        }
        if actionName == "Energy" {
            item1TFWidth.constant = item1LabelWidth.constant
            item1LabelWidth.constant = 0
            
            secondItemViewHeight.constant = 0
            secondItemViewTop.constant = 0
            
            item1TF.placeholder = "Equipment"
            input1TF.placeholder = "Energy Source (Wise Wizards)"
            input2TF.placeholder = "Move(ex. Grandparents Blessing)"
            fetchAssetEquipment()
            fetchTargets()
            fetchMoves()
            
            proceedButton.setImage(UIImage(named: "Energy"), for: .normal)
            
        }
        
        
        
    }
    
    
    //buttons Tapped
    //items 1 and 2
    @IBAction func item1ButtonTapped(_ sender: Any) {
        //active for all, but items should be regulated during action setup
        //TF1 in sickness and energy
        
        if actionName == "Smith" {
            //reset item 2
            item2Button.isEnabled = false
            item2TF.isEnabled = false
            item2TF.text = "Select power source"
            valueLabel2.text = "NA"
            
        }
        
        if picker.isHidden {
            pickerChoice = "equipment"
            item1Label.textColor = #colorLiteral(red: 0, green: 0.2883095741, blue: 0.6653674245, alpha: 1)
            pickerTappedSetup()
        } else {
            //if open but not the right choice
            if pickerChoice != "equipment" {
                
                pickerChoice = "equipment"
                item1Label.textColor = #colorLiteral(red: 0, green: 0.2883095741, blue: 0.6653674245, alpha: 1)
                if actionName == "Cleanse" {
                    item2Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                }
                pickerTappedSetup()
            } else {
                picker.isHidden = true
                item1Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        
    }
    
    
    @IBAction func item2ButtonTapped(_ sender: Any) {
        //smith and cleanse only
        //handle item2TF for smith
        if picker.isHidden {
            pickerChoice = "secondaryEquipment"
            if actionName == "Smith" {
                item2TF.text = ""
            }
            if actionName == "Cleanse" {
                item2Label.textColor = #colorLiteral(red: 0, green: 0.2883095741, blue: 0.6653674245, alpha: 1)
            }
            pickerTappedSetup()
        } else {
            //picker not hidden
            picker.isHidden = true
            if actionName == "Cleanse" {
                item2Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else {
                item1Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }

    }
    
    /////////////////
    //input1 and 2
    @IBAction func input1ButtonTapped(_ sender: Any) {
        //not smith, cleanse, sickness
        if actionName == "Attack" || actionName == "Defend" || actionName == "Energy" {
            if picker.isHidden {
                pickerChoice = "targets"
                pickerTappedSetup()
            } else {
                if pickerChoice != "targets" {
                    if pickerChoice == "equipment" {
                        item1Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    }
                    pickerChoice = "targets"
                    pickerTappedSetup()
                } else {
                    picker.isHidden = true
                }
            }
        }
        if actionName == "Sickness" {
            //only difference in code from above is changing text color
            // can probably be combined
            if picker.isHidden {
                pickerChoice = "targets"
                pickerTappedSetup()
            } else {
                if pickerChoice != "targets" {
                    
                    pickerChoice = "targets"
                    pickerTappedSetup()
                } else {
                    picker.isHidden = true
                }
            }
        }
        
    }
    
    @IBAction func input2ButtonTapped(_ sender: Any) {
        //att/def and energy, still loads targets and merchant
        //any differences handled during setup
        if actionName == "Attack" || actionName == "Defend" || actionName == "Energy" {
            if picker.isHidden {
                pickerChoice = "moves"
                pickerTappedSetup()
            } else {
                if pickerChoice != "moves" {
                    if pickerChoice == "equipment" {
                        item1Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    }
                    pickerChoice = "moves"
                    pickerTappedSetup()
                } else {
                    picker.isHidden = true
                }
            }
        }
    }
    
    func pickerTappedSetup() {
        picker.reloadAllComponents()
        picker.isHidden = false
        view.endEditing(true)
    }
    
    ////////
    ////////
    ///////
    //process
    @IBAction func proceedTapped(_ sender: Any) {
        if actionName == "Attack" || actionName == "Defend" {
            if selectedEquipment != nil && selectedTarget != nil && selectedMove != nil && powerInputTF.text != "" {
                
                let sEquipment = selectedEquipment!
                let sTarget = selectedTarget!
                let sMove = selectedMove!
                let damage = Double(powerInputTF.text!)!
                let actionTaken = actionName!
                
                if ActionModel.actionModel.checkFunds(equipment: sEquipment, damage: damage) {
                    //if returns true, then there are enough funds
                    //handleBudget
                    if actionTaken == "Attack" {
                        character.attack += damage
                    } else if actionTaken == "Defend" {
                        character.defense += damage
                    }
                    //equipmentLosesValue or Durability = to damage
                    if sEquipment.category == "asset" {
                        sEquipment.value -= damage
                    } else if sEquipment.category == "credit" {
                        sEquipment.durability -= damage
                        //absolute value taken from credit
                        sEquipment.value += damage
                    }
                    
                    //stamina depleted
                    let totalStamina = UserDefaults.standard.double(forKey: "TotalStamina")
                    let staminaLeft = character.stamina
                    character.stamina += damage
                    //calculate battle details
                    let bdm = BattleDetailModel()
                    let battleDetails = bdm.calculateMathDetail(totalStamina: totalStamina, staminaLeft: staminaLeft, damage: damage)
                    //create the log
                    let log = ActionModel.actionModel.createLogForBudgetAction(equipment: sEquipment, target: sTarget, move: sMove, character: character, damage: damage, action: actionTaken, bd1: battleDetails.0, bd2: battleDetails.1)
                    print(log)
                    ad.saveContext()
                    //segue to 'receipt' pop up, dismiss and then pop navigationcontroller?
                    performSegue(withIdentifier: "receiptSegue", sender: log)
                    
                } else {
                    print("Not enough funds")
                }
                
                
                
            }
            
        }
        ////////////////////////////////////////////////Smith
        if actionName == "Smith" {
        
            if selectedEquipment != nil && (selectedSecondary != nil || item2TF.text != "") && powerInputTF.text != ""{
                //money is not saved if it is transfered to your main spending account
                //main is not added to secondaryEquipment
                
                if selectedSecondary == nil {
                    let newSecondaryItem = Item(context: context)
                    newSecondaryItem.name = item2TF.text!
                    newSecondaryItem.main = false
                    newSecondaryItem.value = 0
                    newSecondaryItem.category = "asset"
                    character.addToItem(newSecondaryItem)
                    //new item becomes selectedSecondary
                    selectedSecondary = newSecondaryItem
                }
                
                let sEquipment = selectedEquipment!
                let sSecondary = selectedSecondary!
                let damage = Double(powerInputTF.text!)!
                let actionTaken = actionName!
                
                if ActionModel.actionModel.checkFunds(equipment: sEquipment, damage: damage) {
                    //for now.. other stats will be calculated
                    //equipmentLosesValue or Durability = to damage
                    sEquipment.value -= damage
                    sSecondary.value += damage
                    //actions deplete stamina
                    //even for saving, but doesnt effect budget
                    let totalStamina = UserDefaults.standard.double(forKey: "TotalStamina")
                    let staminaLeft = character.stamina
                    character.stamina += damage
                    
                    //SmithDetails to be made and incorporate stamina
                    let log = ActionModel.actionModel.createLogForSmithAction(equipment: sEquipment, secondary: sSecondary, character: character, damage: damage, action: actionTaken, bd1: nil, bd2: nil)
                    
                    ad.saveContext()
                    print("smith log: \(log)")
                    
                    performSegue(withIdentifier: "receiptSegue", sender: log)
                    
                }
                
            }
        }
        //////////////////////////////////////////Cleanse
        if actionName == "Cleanse" {
            if selectedEquipment != nil && selectedSecondary != nil && powerInputTF.text != ""{
                let sEquipment = selectedEquipment!
                let sSecondary = selectedSecondary!
                let power = Double(powerInputTF.text!)!
                let actionTaken = actionName!
                if ActionModel.actionModel.checkDebtPowerAsset(equipment: sEquipment, affliction: sSecondary, power: power) {
                    sEquipment.value -= power
                    //value of debt goes down
                    sSecondary.value -= power
                    character.stamina += power
                    
                    let log = ActionModel.actionModel.createLogForCleanseAction(equipment: sEquipment, secondary: sSecondary, character: character, damage: power, action: actionTaken, bd1: nil, bd2: nil)
                    
                    print("cleanse log: \(log)")
                    ad.saveContext()
                    
                    performSegue(withIdentifier: "receiptSegue", sender: log)
                }
                
            }
        }
        
        ////////////////////////////////////////// Sickness
        if actionName == "Sickness" {
            if (selectedEquipment != nil || item1TF.text != "") && (selectedTarget != nil || input1TF.text != "") && powerInputTF.text != "" {
                
                if selectedEquipment == nil {
                    let newDebtName = item1TF.text!
                    var newDebt = true
                    for debt in equipment {
                        if newDebtName == debt.name {
                            newDebt = false
                        }
                    }
                    if newDebt {
                        let debt = Item(context: context)
                        debt.name = newDebtName
                        debt.debt = true
                        debt.category = "debt"
                        debt.main = false
                        selectedEquipment = debt
                    } else {
                        //already exists
                        print("Debt name already exists")
                        return
                    }
                }
                
                print("passed towards selected target")
                
                if selectedTarget == nil {
                    //check targetname against target narmes
                    let newTargetName = input1TF.text!
                    var newtarget = true
                    for target in targets {
                        if newTargetName == target.name {
                            newtarget = false
                        }
                    }
                    //if targetName is still true... continue
                    if newtarget {
                        let target = Merchant(context: context)
                        target.name = newTargetName
                        selectedTarget = target
                    } else {
                        //target name already exists
                        print("target name already exists")
                        return
                    }
                }
                
                let power = Double(powerInputTF.text!)!
                let actionTaken = actionName!
                
                if selectedEquipment != nil && selectedTarget != nil {
                    let log = ActionModel.actionModel.createLogForSickness(debt: selectedEquipment!, source: selectedTarget!, damage: power, action: actionTaken)
                    print("sickness log: \(log)")
                    
                    performSegue(withIdentifier: "receiptSegue", sender: log)
                    
                }
            }
        }
        
        if actionName == "Energy" {
            if (selectedEquipment != nil || item1TF.text != "") && (selectedTarget != nil || input1TF.text != "") && (selectedMove != nil || input2TF.text != "") && powerInputTF.text != "" {
                
                if selectedEquipment == nil {
                    let newDebtName = item1TF.text!
                    var newDebt = true
                    for debt in equipment {
                        if newDebtName == debt.name {
                            newDebt = false
                        }
                    }
                    if newDebt {
                        let debt = Item(context: context)
                        debt.name = newDebtName
                        debt.debt = true
                        debt.category = "debt"
                        debt.main = false
                        selectedEquipment = debt
                    } else {
                        //already exists
                        print("Debt name already exists")
                        return
                    }
                }
                
                print("passed towards selected target")
                
                if selectedTarget == nil {
                    //check targetname against target narmes
                    let newTargetName = input1TF.text!
                    var newtarget = true
                    for target in targets {
                        if newTargetName == target.name {
                            newtarget = false
                        }
                    }
                    //if targetName is still true... continue
                    if newtarget {
                        let target = Merchant(context: context)
                        target.name = newTargetName
                        selectedTarget = target
                    } else {
                        //target name already exists
                        print("target name already exists")
                        return
                    }
                }
                
                if selectedMove == nil {
                    //check targetname against target narmes
                    let newMovetName = input2TF.text!
                    var newMove = true
                    for move in moves {
                        if newMovetName == move.name {
                            newMove = false
                        }
                    }
                    //if targetName is still true... continue
                    if newMove {
                        let move = Move(context: context)
                        move.name = newMovetName
                        selectedMove = move
                    } else {
                        //target name already exists
                        print("move name already exists")
                        return
                    }
                }
                
                let power = Double(powerInputTF.text!)!
                let actionTaken = actionName!
                
                if selectedEquipment != nil && selectedTarget != nil && selectedMove != nil {
                    let log = ActionModel.actionModel.createLogForEnergy(equipment: selectedEquipment!, source: selectedTarget!, move: selectedMove!, damage: power, action: actionTaken)
                    print("energy log: \(log)")
                    
                    performSegue(withIdentifier: "receiptSegue", sender: log)
                    
                }
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "receiptSegue" {
            if let destination = segue.destination as? ReceiptVC {
                if let log = sender as? Log {
                    destination.receipt = log
                }
            }
        }
    }
    
    
    
    
    ////
    //Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerChoice == "equipment" {
            //load debt into equipment for sickness since it's the only item
            //smith handles own asset fetching
            //
            if !equipment.isEmpty {
                return equipment.count
            } else {
                return 1
            }
        }
        
        if pickerChoice == "secondaryEquipment" {
            if actionName == "Smith" {
                if !secondaryEquipment.isEmpty {
                    //equipment appended to string array + 1 for 'new item"
                    return secondaryEquipment.count + 1
                } else {
                    return 1
                }
            }
            if actionName == "Cleanse" {
                if !secondaryEquipment.isEmpty {
                    return secondaryEquipment.count
                } else {
                    return 1
                }
            }
        }
        
        if pickerChoice == "targets" {
            if actionName == "Sickness" || actionName == "Energy" {
                if !targets.isEmpty {
                    //option to add new
                    return targets.count + 1
                }
            }
            
            if !targets.isEmpty {
                return targets.count
            } else {
                return 1
            }
        }
        if pickerChoice == "moves" {
            if actionName == "Energy" {
                if !moves.isEmpty {
                    return moves.count + 1
                }
            } else {
                return 1
            }
            
            if !moves.isEmpty {
                return moves.count
            } else {
                return 1
            }
        }
        
        return 1
    }
    
    ////////////
    ////////////
    ////////////
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerChoice == "equipment" {
            
            if !equipment.isEmpty {
                var equipmentNames: [String] = []
                for item in equipment {
                    let name = item.name
                    equipmentNames.append(name!)
                }
                return equipmentNames[row]
            }
        }
        
        if pickerChoice == "secondaryEquipment" {
            if !secondaryEquipment.isEmpty {
                ////smith instructions
                //secondary equipment should be made onces equipment has been selected
                //enable item2button/item2TF
                var secondaryEquipNames: [String] = []
                if actionName == "Smith" {
                    secondaryEquipNames.append("New Item")
                }
                for item in secondaryEquipment {
                    let name = item.name
                    secondaryEquipNames.append(name!)
                }
                return secondaryEquipNames[row]
            } else {
                var secondaryEquipNames: [String] = []
                if actionName == "Smith" {
                    secondaryEquipNames.append("New Item")
                }
                return secondaryEquipNames[row]
            }
        }
        
        if pickerChoice == "targets" {
            
            if !targets.isEmpty {
                print("we have targets")
                var targetNames: [String] = []
                
                if actionName == "Sickness" || actionName == "Energy" {
                    targetNames.append("New Target")
                }
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
                if actionName == "Energy" {
                    moveNames.append("New Move")
                }
                
                for move in moves {
                    let name = move.name
                    moveNames.append(name!)
                }
                return moveNames[row]
            }
        }
        return "Error with setting up titleForRow"
    }
    
    //////////////
    ////////////
    ///////////
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //will need to fix for selection of second item
        if actionName == "Attack" || actionName == "Defend" {
            if pickerChoice == "equipment" {
                
                selectedEquipment = equipment[row]
                item1Label.textColor = UIColor.black
                item1Label.text = selectedEquipment?.name
                valueLabel1.text = String(format: "%0.2f", (selectedEquipment?.value)!)
                if selectedEquipment!.value < 0.0 {
                    itemImage1.image = UIImage(named: "Affliction")
                } else {
                    itemImage1.image = UIImage(named: "Power")
                }
                if selectedEquipment!.category == "credit" {
                    magicLabel1.text = String(format: "%0.2f", selectedEquipment!.durability)
                } else {
                    magicLabel1.text = "NA"
                }
                pickerView.isHidden = true
            }
            if pickerChoice == "targets" {
                selectedTarget = targets[row]
                //selected target shows up in TF
                input1TF.text = selectedTarget?.name
                pickerView.isHidden = true
            }
            if pickerChoice == "moves" {
                selectedMove = moves[row]
                input2TF.text = selectedMove?.name
                pickerView.isHidden = true
            }
        }
        //
        if actionName == "Smith" {
            //item 1 can only be positive, it is not an upgrade/saving if you use credit (fake money) or increase debt
            //will need a custom fetch then
            if pickerChoice == "equipment" {
                
                selectedEquipment = equipment[row]
                item1Label.textColor = UIColor.black
                item1Label.text = selectedEquipment?.name
                valueLabel1.text = String(format: "%0.2f", (selectedEquipment?.value)!)
                
                //secondaryEquipment reset
                secondaryEquipment = []
                selectedSecondary = nil
                item2Button.isEnabled = true
                item2TF.isEnabled = true
                item2TF.text = ""
                item2TF.placeholder = "New item?"
                
                //secondary equipment equals whatever is left over
                for item in equipment {
                    //is it the same item
                    //secondary item is to save, adding to main item (spending) is not saving
                    if item !== selectedEquipment && item.main == false {
                        secondaryEquipment.append(item)
                        print("item \(item) appended to secondary equipment")
                    }
                }
                //enable secondary button/tf
                //tf should read 'select power source/equipment'
                
                pickerView.isHidden = true
                
                
        
            }
            if pickerChoice == "secondaryEquipment" {
                if row > 0 {
                    //row 0 is 'new item' string
                    selectedSecondary = secondaryEquipment[row - 1]
                    item2TF.text = selectedSecondary?.name
                    valueLabel2.text = String(format: "%0.2f", (selectedSecondary?.value)!)
                    
                } else {
                    //reset selected secondary
                    item2TF.text = ""
                    item2TF.placeholder = "New Item"
                    selectedSecondary = nil
                    item2TF.becomeFirstResponder()
                    
                }
                
                pickerView.isHidden = true
            }
        }
        if actionName == "Cleanse" {
            if pickerChoice == "equipment" {
                
                selectedEquipment = equipment[row]
                item1Label.textColor = UIColor.black
                item1Label.text = selectedEquipment?.name
                valueLabel1.text = String(format: "%0.2f", (selectedEquipment?.value)!)
                if selectedEquipment!.value < 0.0 {
                    itemImage1.image = UIImage(named: "Affliction")
                } else {
                    itemImage1.image = UIImage(named: "Power")
                }
//                if selectedEquipment!.category == "credit" {
//                    magicLabel1.text = String(format: "%0.2f", selectedEquipment!.durability)
//                } else {
//                    magicLabel1.text = "NA"
//                }
                pickerView.isHidden = true
            }
            
            if pickerChoice == "secondaryEquipment" {
                
                selectedSecondary = secondaryEquipment[row]
                item2Label.textColor = UIColor.black
                item2Label.text = selectedSecondary?.name
                if selectedSecondary?.category == "credit" {
                    magicLabel2.text = String(format: "%0.2f", (selectedSecondary?.durability)!)
                } else {
                    magicLabel2.text = "NA"
                }
                valueLabel2.text = String(format: "%0.2f", (selectedSecondary?.value)!)
                
                
                
                pickerView.isHidden = true
            }
        }
        if actionName == "Sickness" {
            //only one picker
            if pickerChoice == "equipment" {
                selectedEquipment = equipment[row]
                item1TF.text = selectedEquipment?.name
                if selectedEquipment?.category == "credit" {
                    magicLabel1.text = String(format: "%0.2f", (selectedEquipment?.durability)!)
                } else {
                    magicLabel1.text = "NA"
                }
                valueLabel1.text = String(format: "%0.2f", (selectedEquipment?.value)!)
                
                pickerView.isHidden = true
                
            }
            
            if pickerChoice == "targets" {
                if row > 0 {
                    selectedTarget = targets[row - 1]
                    //selected target shows up in TF
                    input1TF.text = selectedTarget?.name
                    pickerView.isHidden = true
                } else {
                    //selecting New Item in general resets the target
                    input1TF.text = ""
                    selectedTarget = nil
                    input1TF.becomeFirstResponder()
                    pickerView.isHidden = true
                }
            }
            
        }
        
        if actionName == "Energy" {
            if pickerChoice == "equipment" {
                //should only be assets
                selectedEquipment = equipment[row]
                item1TF.text = selectedEquipment?.name
                valueLabel1.text = String(format: "%0.2f", (selectedEquipment?.value)!)
                magicLabel1.text = "NA"
                
                pickerView.isHidden = true
            }
            
            if pickerChoice == "targets" {
                if row > 0 {
                    selectedTarget = targets[row - 1]
                    //selected target shows up in TF
                    input1TF.text = selectedTarget?.name
                    pickerView.isHidden = true
                } else {
                    //selecting New Item in general resets the target
                    input1TF.text = ""
                    selectedTarget = nil
                    input1TF.becomeFirstResponder()
                    pickerView.isHidden = true
                }
            }
            
            if pickerChoice == "moves" {
                if row > 0 {
                    selectedMove = moves[row - 1]
                    //selected target shows up in TF
                    input2TF.text = selectedMove?.name
                    pickerView.isHidden = true
                } else {
                    //selecting New Item in general resets the target
                    input2TF.text = ""
                    selectedTarget = nil
                    input2TF.becomeFirstResponder()
                    pickerView.isHidden = true
                }
            }
        }
    }
    
    
    
    ///////////////////////////////////////////////////////////////////////////
    ///////fetches
    func fetchPlayer() {
        character = ActionModel.actionModel.fetchPlayer()
    }
    func fetchEquipment() {
        equipment = ActionModel.actionModel.fetchEquipment()
    }
    func fetchAssetEquipment() {
        //smithing
        //secondary items assigned after first item chose
        equipment = ActionModel.actionModel.fetchAssetEquipment()
    }
    func fetchDebtEquipment() {
        secondaryEquipment = ActionModel.actionModel.fetchDebtEquipment()
    }
    
    func fetchTargets() {
        targets = ActionModel.actionModel.fetchTargets()
    }
    func fetchMoves() {
        moves = ActionModel.actionModel.fetchMoves()
    }

   
    ///////////////////////////////////////////////////////////////////////////
    ////Textfield
    func textFieldDidEndEditing(_ textField: UITextField) {
        if input1TF.text != "" {
            if selectedTarget != nil {
                if input1TF.text != selectedTarget?.name {
                    
                }
            } else {
                
            }
        }
        
        if let text = Double(powerInputTF.text!) {
            powerInputTF.text = String(format: "%0.2f", text)
        } else {
            powerInputTF.text = "0.00"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if powerInputTF.isFirstResponder {
            powerInputTF.resignFirstResponder()
        }
        if input2TF.isFirstResponder {
            input2TF.resignFirstResponder()
        }
        if input1TF.isFirstResponder {
            input1TF.resignFirstResponder()
        }
        if item2TF.isFirstResponder {
            item2TF.resignFirstResponder()
        }
        if item1TF.isFirstResponder {
            item1TF.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //if you begin writing and the picker is open, close it
        if !picker.isHidden  {
            //if picker is for equipment, change color back too
            if pickerChoice == "equipment" {
                item1Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            picker.isHidden = true
        }
        if powerInputTF.isFirstResponder {
            powerInputTF.text = ""
        }
        
        //if editing a textfield, it deletes field and removes selectedObject
        if item1TF.isFirstResponder {
            item1TF.text = ""
            selectedEquipment = nil
        }
        if input1TF.isFirstResponder {
            input1TF.text = ""
            selectedTarget = nil
        }
        
    }
    
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
//end
}
