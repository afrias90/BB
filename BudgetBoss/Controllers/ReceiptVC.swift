//
//  ReceiptVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/7/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class ReceiptVC: UIViewController {
    
    var receipt: Log?

    @IBOutlet weak var actionTitleLabel: UILabel!
    @IBOutlet weak var targetNameLabel: UILabel!
    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var equipmentNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if receipt != nil {
            receiptSetup()
        } else {
            actionTitleLabel.text = "Error"
        }
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func receiptSetup() {
        //should not be nil if this code is running
        
        let log = receipt!
        actionTitleLabel.text = log.category
        if log.category == "Attack" || log.category == "Defend" {
            targetNameLabel.text = log.targetName
            moveNameLabel.text = log.moveName
            powerLabel.text = String(format: "%0.2f", log.power)
            equipmentNameLabel.text = log.itemName
        }
        if log.category == "Smith" {
            targetNameLabel.text = log.targetName
            moveNameLabel.text = "Smithing"
            powerLabel.text = String(format: "%0.2f", log.power)
            equipmentNameLabel.text = log.itemName
        }
        if log.category == "Cleanse" {
            targetNameLabel.text = log.targetName
            moveNameLabel.text = "Cleansing"
            powerLabel.text = String(format: "%0.2f", log.power)
            equipmentNameLabel.text = log.itemName
        }
        if log.category == "Sickness" {
            targetNameLabel.text = log.targetName
            moveNameLabel.text = "Sickness"
            powerLabel.text = String(format: "%0.2f", log.power)
            equipmentNameLabel.text = log.itemName
        }
        if log.category == "Energy" {
            targetNameLabel.text = log.targetName
            moveNameLabel.text = "Energy"
            powerLabel.text = String(format: "%0.2f", log.power)
            equipmentNameLabel.text = log.itemName
        }
        
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    

   

}
