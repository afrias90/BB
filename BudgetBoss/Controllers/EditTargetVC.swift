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
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(EditTargetVC.closeTap(_:)))
        view.addGestureRecognizer(closeTouch)
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
            title = "Edit"
        } else {
            title = "Create Target"
            createButton.isHidden = false
        }
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Delete Targets", message: "Are you were sure you want to delete Target?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "DELETE", style: .destructive, handler: { Void in
            
            if self.targetToEdit != nil {
                context.delete(self.targetToEdit!)
                ad.saveContext()
            }
            
            self.navigationController?.popViewController(animated: true)
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(cancelAction)
        self.present(ac, animated: true, completion: nil)
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
    
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    
    
    
}
