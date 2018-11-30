//
//  CreateCharacterVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/13/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class CreateCharacterVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var paycheckTxt: UITextField!
    @IBOutlet weak var classNameButton: UIButton!
    @IBOutlet weak var classPicker: UIPickerView!
    
    let characterClass = [
    "Choose Class",
    "Watchman",
    "Fighter",
    "Guardian",
    "Blacksmith",
    "Cursed Warrior",
    "Jack of all Trades"
    ]
    var selectedClass = ""
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classPicker.delegate = self
        classPicker.dataSource = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateCharacterVC.handleTap))
        view.addGestureRecognizer(tap)
        nameTxt.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        spinner.isHidden = true
        
    }
    
    @IBAction func chooseClassTapped(_ sender: Any) {
        if classPicker.isHidden {
            classPicker.isHidden = false
            view.endEditing(true)
        } else {
            classPicker.isHidden = true
        }
    }
    

   
    @IBAction func createPressed(_ sender: Any) {
        
        //guard let name = nameTxt.text, name != "" else {return}
        
        if paycheckTxt.text != "", nameTxt.text != "", let name = nameTxt.text, selectedClass != "" {
//            spinner.isHidden = false
//            spinner.startAnimating()
            let stamina = Double(paycheckTxt.text!)!
            
            createUser(name: name, stamina: stamina) { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("failed to create user and did not dismiss")
                    
                }
//                self.spinner.isHidden = true
//                self.spinner.stopAnimating()
            }
        } else {
            print("paycheck or name missing")
        }
        
    }
    
    func createUser(name: String, stamina: Double, completion: @escaping CompletionHandler) {
        
        let character = Character(context: context)
        character.name = name
        
        //stamina used up, the total will be stored in defaults
        character.stamina = 0.0
        //total stamina (pay day amount) should be added to defaults, and can be changed when a new payday is made
        UserDefaults.standard.set(stamina, forKey: "TotalStamina")
        
        //default for now
        character.charClass = selectedClass
        
        let mainItem = Item(context: context)
        mainItem.main = true
        mainItem.name = "Sword Of Hope"
        mainItem.category = "asset"
        character.addToItem(mainItem)
        //main item set to 0.00 for now...
        
        
        //print("\(character.name, character.stamina)")
        //print("\(mainItem.name, mainItem.category)")
        ad.saveContext()
        
        completion(true)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if paycheckTxt.isFirstResponder {
            paycheckTxt.resignFirstResponder()
            if let text = Double(paycheckTxt.text!) {
                paycheckTxt.text = String(format: "%0.2f", text)
            } else {
                paycheckTxt.text = ""
            }
        }
        
        if nameTxt.isFirstResponder {
            nameTxt.resignFirstResponder()
            paycheckTxt.becomeFirstResponder()
        }
        
        return true
        
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let text = Double(paycheckTxt.text!) {
            paycheckTxt.text = String(format: "%0.2f", text)
        } else {
            paycheckTxt.text = ""
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characterClass.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let choice = characterClass[row]
        return choice
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row > 0 {
            let choice = characterClass[row]
            selectedClass = choice
            classNameButton.setTitle(choice, for: .normal)
            classNameButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            
            classPicker.isHidden = true
        } else {
            
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !classPicker.isHidden {
            classPicker.isHidden = true
        }
    }

  
    

}
