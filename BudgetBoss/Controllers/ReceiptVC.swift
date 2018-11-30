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
    var receiptDetail = false
    
    
    @IBOutlet weak var receiptImage: UIImageView!
    @IBOutlet weak var statsViewBg: StatsView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var actionTitleLabel: UILabel!
    @IBOutlet weak var labelTitle1: UILabel!
    @IBOutlet weak var logName1: UILabel!
    @IBOutlet weak var labelTitle2: UILabel!
    @IBOutlet weak var logName2: UILabel!
    @IBOutlet weak var labelTitle3: UILabel!
    @IBOutlet weak var logName3: UILabel!
    @IBOutlet weak var labelTitle4: UILabel!
    @IBOutlet weak var logName4: UILabel!
    @IBOutlet weak var labelTitle5: UILabel!
    @IBOutlet weak var logName5: UILabel!
    @IBOutlet weak var labelTitle6: UILabel!
    @IBOutlet weak var logName6: UILabel!
    @IBOutlet weak var labelTitle7: UILabel!
    @IBOutlet weak var logName7: UILabel!
    @IBOutlet weak var labelTitle8: UILabel!
    @IBOutlet weak var logName8: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if receipt != nil {
            receiptSetup()
        } else {
            actionTitleLabel.text = "Error"
        }
        
        if receiptDetail {
            
            doneButton.isHidden = true
            statsViewBg.backgroundColor = #colorLiteral(red: 0.8331184983, green: 0.8332590461, blue: 0.8331000805, alpha: 1)
            leadingConstraint.constant = 0
            trailingConstraint.constant = 0
            topConstraint.constant = 0
        } else {
            self.navigationItem.setHidesBackButton(true, animated: true)
        }
    }
    
    func receiptSetup() {
        //should not be nil if this code is running
        
        let log = receipt!
        actionTitleLabel.text = log.category
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        if log.category == "Attack" || log.category == "Defend" {
            labelTitle1.text = "Target:"
            logName1.text = log.targetName
            labelTitle2.text = "Move:"
            logName2.text = log.moveName
            labelTitle3.text = "Damage:"
            logName3.text = String(format: "%0.2f", log.power)
            labelTitle4.text = "Equipment:"
            logName4.text = log.itemName
            labelTitle5.text = "Power:"
            logName5.text = String(format: "%0.2f", log.itemNewPower)
            labelTitle6.text = "Expense?"
            
            if log.expense {
                logName6.text = "True"
            } else {
                logName6.text = "False"
            }
            
            labelTitle7.text = ""
            logName7.text = ""
            labelTitle8.text = "Date"
            
            if log.date != nil {
                logName8.text = dateFormatter.string(from: log.date!)
            }
            if log.category == "Attack" {
                receiptImage.image = UIImage(named: "Attack")
            } else {
                receiptImage.image = UIImage(named: "Defense")
            }
        }
        if log.category == "Smith" {
            labelTitle1.text = "Target:"
            logName1.text = log.targetName
            labelTitle2.text = "Move:"
            logName2.text = log.moveName
            labelTitle3.text = "Power Transfer:"
            logName3.text = String(format: "%0.2f", log.power)
            labelTitle4.text = "Equipment:"
            logName4.text = log.itemName
            labelTitle5.text = "Power:"
            logName5.text = String(format: "%0.2f", log.itemNewPower)
            labelTitle6.text = "Expense?"
            if log.expense {
                logName6.text = "True"
            } else {
                logName6.text = "False"
            }
            labelTitle7.text = ""
            logName7.text = ""
            labelTitle8.text = "Date"
            
            if log.date != nil {
                logName8.text = dateFormatter.string(from: log.date!)
            }
            receiptImage.image = UIImage(named: "Upgrades")
        }
        if log.category == "Cleanse" {
            labelTitle1.text = "Curse:"
            logName1.text = log.targetName
            labelTitle2.text = "Move:"
            logName2.text = log.moveName
            labelTitle3.text = "Debt:"
            logName3.text = String(format: "%0.2f", log.targetNewPower)
            
            //amount cleansed
            labelTitle4.text = "Power:"
            logName4.text = String(format: "%0.2f", log.power)
            labelTitle5.text = "Equipment:"
            logName5.text = log.itemName
            labelTitle6.text = "Power:"
            logName6.text = String(format: "%0.2f", log.itemNewPower)
            labelTitle7.text = "Expense?"
            if log.expense {
                logName7.text = "True"
            } else {
                logName7.text = "False"
            }
            labelTitle8.text = "Date"
            
            if log.date != nil {
                logName8.text = dateFormatter.string(from: log.date!)
            }
            receiptImage.image = UIImage(named: "Cleanse")
        }
        if log.category == "Sickness" {
            labelTitle1.text = "Source:"
            logName1.text = log.targetName
            labelTitle2.text = "Move:"
            logName2.text = log.moveName
            labelTitle3.text = ""
            logName3.text = ""
            
            labelTitle4.text = "Damage:"
            logName4.text = String(format: "%0.2f", log.power)
            labelTitle5.text = "Equipment:"
            logName5.text = log.itemName
            labelTitle6.text = "Debt:"
            logName6.text = String(format: "%0.2f", log.itemNewPower)
            labelTitle7.text = "Expense?"
            if log.expense {
                logName7.text = "True"
            } else {
                logName7.text = "False"
            }
            labelTitle8.text = "Date"
            
            if log.date != nil {
                logName8.text = dateFormatter.string(from: log.date!)
            }
            receiptImage.image = UIImage(named: "sickness")
        }
        if log.category == "Energy" {
            logName1.text = log.targetName
            logName2.text = "Energy"
            logName3.text = String(format: "%0.2f", log.power)
            logName4.text = log.itemName
            ////
            ///
            labelTitle1.text = "Energy Source:"
            logName1.text = log.targetName
            labelTitle2.text = "Move:"
            logName2.text = log.moveName
            labelTitle3.text = "Energy"
            logName3.text = String(format: "%0.2f", log.power)
            
            labelTitle4.text = ""
            logName4.text = ""
            labelTitle5.text = "Equipment:"
            logName5.text = log.itemName
            labelTitle6.text = "Power:"
            logName6.text = String(format: "%0.2f", log.itemNewPower)
            labelTitle7.text = "Expense?"
            if log.expense {
                logName7.text = "True"
            } else {
                logName7.text = "False"
            }
            labelTitle8.text = "Date"
            
            if log.date != nil {
                logName8.text = dateFormatter.string(from: log.date!)
                receiptImage.image = UIImage(named: "Energy")
            }
            
            if log.current {
                print("log is current")
            } else {
                print("log is old")
            }
            
        }
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
}
