//
//  EditCatVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/4/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class EditCatVC: UIViewController, UITextFieldDelegate {
    
    var catToEdit: ObjCategory?
    @IBOutlet weak var createCatButton: UIButton!
    
    @IBOutlet weak var categoryNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if catToEdit != nil {
            setupCat()
        }
        createCatButtonSetup()
        
    }
    
    @IBAction func createCatTapped(_ sender: Any) {
        if categoryNameTF.text != "" {
            let newCat = ObjCategory(context: context)
            newCat.name = categoryNameTF.text
            ad.saveContext()
            navigationController?.popViewController(animated: true)
        } else {
            print("Can't save blank category name")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if categoryNameTF.isFirstResponder {
            categoryNameTF.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if categoryNameTF.text == "" {
            if catToEdit != nil {
                categoryNameTF.text = catToEdit?.name
            } else {
                if categoryNameTF.text!.count > 15 {
                    categoryNameTF.text = ""
                }
            }
        }
        
        if catToEdit != nil {
            if categoryNameTF.text != catToEdit?.name {
                catToEdit?.name = categoryNameTF.text
                ad.saveContext()
            }
        }
        
    }
    
    func setupCat() {
        categoryNameTF.text = catToEdit?.name
    }
    
    func createCatButtonSetup() {
        if catToEdit != nil {
            createCatButton.isHidden = true
        } else {
            createCatButton.isHidden = false
        }
    }
    
}
