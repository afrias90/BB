//
//  CreateCharacterVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/13/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class CreateCharacterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var paycheckTxt: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateCharacterVC.handleTap))
        view.addGestureRecognizer(tap)
        nameTxt.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        spinner.isHidden = true
        
    }

   
    @IBAction func createPressed(_ sender: Any) {
        
        //guard let name = nameTxt.text, name != "" else {return}
        
        if paycheckTxt.text != "", nameTxt.text != "", let name = nameTxt.text {
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
        
        character.category = "Cursed Warrior"
        
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

  
    

}
