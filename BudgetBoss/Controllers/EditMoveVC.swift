//
//  EditMoveVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/4/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class EditMoveVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    var moveToEdit: Move?
    var selectedCat: ObjCategory?
    var categoryList: [ObjCategory] = []
    
    
    @IBOutlet weak var moveNameTF: UITextField!
    @IBOutlet weak var actualMoveNameTF: UITextField!
    @IBOutlet weak var moveCategoryTF: UITextField!
    @IBOutlet weak var addCategoryButton: UIButton!
    @IBOutlet weak var catPicker: UIPickerView!
    
    
    
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catPicker.delegate = self
        catPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if moveToEdit != nil {
            setupMove()
        }
        createMoveButtonSetup()
        fetchCatList()
        catPicker.reloadAllComponents()
    }
    
    
    @IBAction func createMoveTapped(_ sender: Any) {
        
        let move = Move(context: context)
        move.name = moveNameTF.text
        move.actualName = actualMoveNameTF.text
        
        //only adds new moves to existing categories
        //there was a cat selected
        if selectedCat != nil {
            if selectedCat?.name == moveCategoryTF.text {
                //if cat was selected and still matches TF, then add
                selectedCat?.addToMove(move)
            } else {
                //selected cat doesn't match TF,
                //if functions finds matching cat name, then selectedCat will become it
                createNewCategory(move: move)
                //selectedCat?.addToMove(move)
            }
            
        } else {
            //no cat selected
            if moveCategoryTF.text != "" {
                createNewCategory(move: move)
            }
        }
        
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func setupMove() {
        moveNameTF.text = moveToEdit?.name
        actualMoveNameTF.text = moveToEdit?.actualName
        moveCategoryTF.text = moveToEdit?.category?.name
    }
    
    
    
    @IBAction func addCategoryTapped(_ sender: Any) {
        if catPicker.isHidden == true {
            catPicker.isHidden = false
        } else {
            catPicker.isHidden = true
        }
    }
    
    
    func createMoveButtonSetup() {
        if moveToEdit != nil {
            createButton.isHidden = true
        } else {
            createButton.isHidden = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if moveCategoryTF.isFirstResponder {
            moveCategoryTF.resignFirstResponder()
        }
        if actualMoveNameTF.isFirstResponder {
            actualMoveNameTF.resignFirstResponder()
        }
        if moveNameTF.isFirstResponder {
            moveNameTF.resignFirstResponder()
            //if actual is still empty, usually new item, then go to actualtextfield
            if actualMoveNameTF.text == "" {
                actualMoveNameTF.becomeFirstResponder()
            }
        }
        
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //no empty strings, and below 25 characters (limit for now)
        if moveNameTF.text == "" {
            if moveToEdit != nil {
                moveNameTF.text = moveToEdit?.name
            } else {
                if (moveNameTF.text?.count)! > 25 {
                    //for a new item this must have something and below 25 characters
                    moveNameTF.text = ""
                }
            }
        }
        //handles saving after editing has ended on Editing item
        if moveToEdit != nil {
            if moveNameTF.text != moveToEdit?.name {
                moveToEdit?.name = moveNameTF.text
                ad.saveContext()
            }
            if actualMoveNameTF.text != moveToEdit?.actualName {
                moveToEdit?.actualName = actualMoveNameTF.text
                ad.saveContext()
            }
        }
        
        if moveCategoryTF.text != "" && moveToEdit != nil {
            //can't be empty, and there is a move to edit
            createNewCategory(move: moveToEdit!)
            
        }
       
    }
    
    func createNewCategory(move: Move) {
        var newCat = true
        for category in categoryList {
            //if moveCategory matches a category, then it is not new
            if moveCategoryTF.text == category.name {
                newCat = false
                //and selected cat becomes that category
                selectedCat = category
                selectedCat?.addToMove(move)
                
            }
        }
        
        
        if newCat == true {
            let newCategory = ObjCategory(context: context)
            newCategory.name = moveCategoryTF.text
            newCategory.addToMove(move)
            // two were added, will appending to list stop it?
            categoryList.append(newCategory)
        }
    }
    
    
    
    func fetchCatList() {
        do {
            let results = try context.fetch(ObjCategory.fetchRequest()) as [ObjCategory]
            if results.count > 0 {
                categoryList = results
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // if there's a move, add it to the new category, otherwise just have it in selectedCat to save new Item
        selectedCat = categoryList[row]
        moveCategoryTF.text = selectedCat?.name
        catPicker.isHidden = true
        if moveToEdit != nil {
            selectedCat?.addToMove(moveToEdit!)
        }
        ad.saveContext()
        
    }
    
    
    
    

}
