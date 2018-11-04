//
//  ActionVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/1/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class ActionVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    //variables
    var actionName: String?
    var targets: [Merchant]?
    var moves: [Object]?
    var equipment: [Item] = []
    var pickerChoice = ""
    
    //optionals that must be present to proceed
    var selectedEquipment: Item?
    
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
            if targets != nil {
                return (targets?.count)!
            } else {
                return 1
            }
        } else if pickerChoice == "moves" {
            if moves != nil {
                return (moves?.count)!
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
        itemPowerLabel.text = "??"
        itemMagicLabel.text = "??"
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
        
    }
    
    func fetchMoves() {
        
    }
    

}
