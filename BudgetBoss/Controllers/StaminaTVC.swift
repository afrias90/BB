//
//  StaminaTVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 10/20/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class StaminaTVC: UITableViewController {
    
    //stored in userdefaults
    var staminaTotal: Double?
    
    //obtained from the previous controller
    var staminaLeft: Double?
    
    // variables
    var today = Date()
    var startDate = Date()
    var datepickerHidden = true
    
    //section 0
    @IBOutlet weak var staminaAmount: UILabel!
    @IBOutlet weak var progressBarWidth: NSLayoutConstraint!
    
    //section 1
    @IBOutlet weak var startdateButton: UIButton!
    @IBOutlet weak var todaysDate: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //section 2
    
    @IBOutlet weak var DaysSince: UILabel!
    @IBOutlet weak var stamPerDay: UILabel!
    @IBOutlet weak var stamPerWeek: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startDate = UserDefaults.standard.object(forKey: "StartDate") as! Date
        setupTodaysDate()
        setupDate()
        setupInfo()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            if datePicker.isHidden == false {
                return 2
            } else {
                return 1
            }
        }
        if section == 2 {
            return 3
        }
        if section == 3 {
            return 1
        }
        return 0
    }
    
    //buttons
    @IBAction func closeTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editTapped(_ sender: Any) {
        //xib file?
    }
    
    @IBAction func startdateTapped(_ sender: Any) {
        
        if datepickerHidden == true {
            datepickerHidden = false
            datePicker.isHidden = false
            startdateButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
            tableView.reloadData()
            
        } else {
            datepickerHidden = true
            datePicker.isHidden = true
            startdateButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            tableView.reloadData()
        }
        
        
    }
    
    
    func setupDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        startdateButton.setTitle(dateFormatter.string(from: startDate), for: .normal)
    }
    
    func setupTodaysDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        todaysDate.text = dateFormatter.string(from: today)
    }
    
    
    @IBAction func dateChanged(_ datePicker: UIDatePicker) {
        startDate = datePicker.date
        UserDefaults.standard.set(startDate, forKey: "StartDate")
        setupDate()
    }
    
    func setupInfo() {
        if staminaTotal == nil || staminaLeft == nil {
            staminaAmount.text = " ? / ? "
        } else {
            staminaAmount.text = "\(staminaLeft) / \(staminaTotal)"
        }
        
    }
    
    
    

}
