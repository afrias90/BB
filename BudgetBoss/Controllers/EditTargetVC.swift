//
//  EditTargetVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/4/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class EditTargetVC: UIViewController, UITextFieldDelegate {
    
    //if no other different functionality is added to target and objects (ex: the use of categories), the two VCs should be comebined into one
    
    var targetToEdit: Merchant?
    
    
    @IBOutlet weak var targetNameTF: UITextField!
    @IBOutlet weak var actualTargetnameTF: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if targetToEdit != nil {
            setupTarget()
        }
        createButtonSetup()
    }
    

    @IBAction func createTapped(_ sender: Any) {
        let target = Merchant(context: context)
        
        //textfield should already be handled... or should i be defensive here too?
        target.name = targetNameTF.text
        target.actualName = actualTargetnameTF.text
        
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func createButtonSetup() {
        if targetToEdit != nil {
            createButton.isHidden = true
        } else {
            createButton.isHidden = false
        }
    }
    
    //can we save as soon as text is done editing?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if actualTargetnameTF.isFirstResponder {
            actualTargetnameTF.resignFirstResponder()
        }
        if targetNameTF.isFirstResponder {
            targetNameTF.resignFirstResponder()
            //if actual is still empty, usually new item, then go to actualtextfield
            if actualTargetnameTF.text == "" {
                actualTargetnameTF.becomeFirstResponder()
            }
        }
        
        return true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //no empty strings, and below 25 characters (limit for now)
        if targetNameTF.text == "" {
            if targetToEdit != nil {
                targetNameTF.text = targetToEdit?.name
            } else {
                //FIX will never run
                if (targetNameTF.text?.count)! > 25 {
                    //for a new item this must have something and below 25 characters
                    targetNameTF.text = ""
                }
            }
        }
        //handles saving after editing has ended on Editing item
        if targetToEdit != nil {
            if targetNameTF.text != targetToEdit?.name {
                targetToEdit?.name = targetNameTF.text
                ad.saveContext()
            }
            if actualTargetnameTF.text != targetToEdit?.actualName {
                targetToEdit?.actualName = actualTargetnameTF.text
                ad.saveContext()
            }
        }
    }

    func setupTarget() {
        targetNameTF.text = targetToEdit?.name
        actualTargetnameTF.text = targetToEdit?.actualName
    }
    
    
    
    
    
    
    
    
    
}
