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
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(EditMoveVC.closeTap(_:)))
        view.addGestureRecognizer(closeTouch)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        deleteButton.isEnabled = false
        if catToEdit != nil {
            setupCat()
        } else {
            title = "Create Category"
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
    
    @IBAction func deleteTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Delete Category", message: "Are you were sure you want to delete category?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "DELETE", style: .destructive, handler: { Void in
            
            if self.catToEdit != nil {
                context.delete(self.catToEdit!)
                ad.saveContext()
            }
            
            self.navigationController?.popViewController(animated: true)
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(cancelAction)
        self.present(ac, animated: true, completion: nil)
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
        deleteButton.isEnabled = true
        title = "Edit"
    }
    
    func createCatButtonSetup() {
        if catToEdit != nil {
            createCatButton.isHidden = true
        } else {
            createCatButton.isHidden = false
        }
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
