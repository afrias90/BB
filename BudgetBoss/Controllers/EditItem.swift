//
//  EditItem.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/16/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

protocol EditItemVCDelegate: class {
    func editItemVCDidCancel(_ controller: EditItem)
    func editItemVC(_ controller: EditItem, didFinishAdding item: Item)
    func editItemVC(_ controller: EditItem, didFinishEditing item: Item)
}

class EditItem: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    //variables
    var itemToEdit: Item?
    var category = "asset"
    var lastTextField: UITextField?
    var player: Character?
    
    weak var delegate: EditItemVCDelegate?
    
    //constraints
    @IBOutlet weak var stackViewLeading: NSLayoutConstraint!
    @IBOutlet weak var statsViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var stackView: UIStackView!
    
    //outlets
    @IBOutlet weak var powerBtn: UIButton!
    @IBOutlet weak var magicBtn: UIButton!
    @IBOutlet weak var afflictionBtn: UIButton!
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var realNameTxtField: UITextField!
    
    @IBOutlet weak var assetValueTxtField: UITextField!
    
    @IBOutlet weak var durabilityTxtField: UITextField!
    @IBOutlet weak var creditValueTxtField: UITextField!
    
    @IBOutlet weak var debtValueTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsViewWidth.constant = view.frame.width - 20
        
        if itemToEdit != nil {
            loadItem()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditItem.handleTap))
        view.addGestureRecognizer(tap)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //so this huge stage view doesnt appear during transitions
        stackView.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        //will this hide the stackview from the itemVC?
        stackView.isHidden = true
    }

  
    @IBAction func powerPressed(_ sender: Any) {
        setupPower()
        
        //selectedCategory(selection: category)
    }
    
    @IBAction func magicPressed(_ sender: Any) {
        setupCredit()
        
        
        //selectedCategory(selection: category)
    }
    
    @IBAction func afflictionPressed(_ sender: Any) {
        setupAffliction()
        
        
        //selectedCategory(selection: category)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        var item: Item?
        
        if itemToEdit != nil {
            item = itemToEdit
        } else {
            item = Item(context: context)
            player?.addToItem(item!)
        }
        if item != nil {
            item?.name = nameTxtField.text
            item?.actualName = realNameTxtField.text
            item?.category = category
            
            switch category {
            case "asset":
                if assetValueTxtField.text != "" {
                    let val = Double(assetValueTxtField.text!)!
                    item?.value = val
                } else {
                    print("error with asset textfield")
                }
            case "credit":
                if creditValueTxtField.text != "" {
                    let val = Double(creditValueTxtField.text!)!
                    item?.value = val
                    if val > 0 {
                        item?.debt = true
                    } else {
                        item?.debt = false
                    }
                } else {
                    print("error with creditValueTextField")
                }
                if durabilityTxtField.text != "" {
                    let durability = Double(durabilityTxtField.text!)!
                    item?.durability = durability
                } else {
                    print("error with durability textfield")
                }
            case "debt":
                if debtValueTxtField.text != "" {
                    let val = Double(debtValueTxtField.text!)!
                    item?.value = val
                    if val > 0 {
                        item?.debt = true
                    } else {
                        item?.debt = false
                    }
                }
            default:
                print("ro oh")
            }

            ad.saveContext()
            //add navigation controll delegate and add popViewController
            navigationController?.popViewController(animated: true)
            
        } else {
            print("error. Item is nil.")
        }
        
        
    }
    
    
    
    
    
    
    func resetPower() {
        powerBtn.setImage(UIImage(named: "unselectedPower"), for: .normal)
    }
    func resetMagic() {
       magicBtn.setImage(UIImage(named: "unselectedMagic"), for: .normal)
    }
    func resetAffliction() {
      afflictionBtn.setImage(UIImage(named: "unselectedAffliction"), for: .normal)
    }
    
    func loadItem() {
        nameTxtField.text = itemToEdit?.name
        realNameTxtField.text = itemToEdit?.actualName
        let category = itemToEdit?.category
        currentState(category: category!)
        
        //if it is the main account, it cannot be changed from asset
        if (itemToEdit?.main)! {
            powerBtn.isEnabled = false
            magicBtn.isEnabled = false
            afflictionBtn.isEnabled = false
        }
        
    }
    
    func currentState(category: String) {
        switch category {
        case "asset":
            setupPower()
            assetValueTxtField.text = String(format: "%0.2f",(itemToEdit?.value)!)
        case "credit":
            setupCredit()
            creditValueTxtField.text = String(format: "%0.2f",(itemToEdit?.value)!)
            durabilityTxtField.text = String(format: "%0.2f",(itemToEdit?.durability)!)
        case "debt":
            setupAffliction()
            debtValueTxtField.text = String(format: "%0.2f",(itemToEdit?.value)!)
        default:
            print("")
        }
    }
    
    func setupPower() {
        category = "asset"
        powerBtn.setImage(UIImage(named: "Power"), for: .normal)
        resetMagic()
        resetAffliction()
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {
            self.stackViewLeading.constant = 10
            
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setupCredit() {
        category = "credit"
        magicBtn.setImage(UIImage(named: "Magic"), for: .normal)
        resetPower()
        resetAffliction()
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {
            self.stackViewLeading.constant = 10 - self.view.frame.width
            
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setupAffliction() {
        category = "debt"
        afflictionBtn.setImage(UIImage(named: "Affliction"), for: .normal)
        resetPower()
        resetMagic()
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {
            self.stackViewLeading.constant = 10 - (self.view.frame.width * 2)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if debtValueTxtField.isFirstResponder {
            debtValueTxtField.resignFirstResponder()
        }
        if creditValueTxtField.isFirstResponder {
            creditValueTxtField.resignFirstResponder()
            
        }
        if durabilityTxtField.isFirstResponder {
            durabilityTxtField.resignFirstResponder()
            creditValueTxtField.becomeFirstResponder()
            
        }
        if assetValueTxtField.isFirstResponder {
            assetValueTxtField.resignFirstResponder()
        }
        if realNameTxtField.isFirstResponder {
            realNameTxtField.resignFirstResponder()
        }
        if nameTxtField.isFirstResponder {
            nameTxtField.resignFirstResponder()
            realNameTxtField.becomeFirstResponder()
        }
        return true
        
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        
        if let text = Double(debtValueTxtField.text!) {
            debtValueTxtField.text = String(format: "%0.2f", text)
        } else {
            debtValueTxtField.text = ""
        }
        
        if let text = Double(creditValueTxtField.text!) {
            creditValueTxtField.text = String(format: "%0.2f", text)
        } else {
            creditValueTxtField.text = ""
        }
        
        if let text = Double(durabilityTxtField.text!) {
            durabilityTxtField.text = String(format: "%0.2f", text)
        } else {
            durabilityTxtField.text = ""
        }
        
        if let text = Double(assetValueTxtField.text!) {
            assetValueTxtField.text = String(format: "%0.2f", text)
        } else {
            assetValueTxtField.text = ""
        }
        
        
        
        
    }
    
    
    
    
    

}
