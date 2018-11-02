//
//  StaminaTVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 10/20/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class StaminaTVC: UITableViewController, StaminaXibVCDelegate {
    
    func staminaXibVCDidCancel(_ controller: StaminaVC) {
        //
    }
    
    func staminaXibVC(_ controller: StaminaVC, didFinishEditing stamina: Double) {
        //new stamina total
        UserDefaults.standard.set(stamina, forKey: "TotalStamina")
        staminaTotal = UserDefaults.standard.double(forKey: "TotalStamina")
        setupInfo()
        calcInfo()
        
        //player stamina may have to be 'how much stamina is used up, and then calculate the left over to make this easy
        //this would require some changes in the code
    }
    
    
    //stored in userdefaults
    var staminaTotal: Double?
    
    //obtained from the previous controller
    var staminaUsed: Double?
    
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
        staminaTotal = UserDefaults.standard.double(forKey: "TotalStamina")
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
                let staminaView = StaminaVC()
                staminaView.delegate = self
                staminaView.modalPresentationStyle = .custom
                present(staminaView, animated: true, completion: nil)
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
        datePicker.setDate(startDate, animated: false)
        
        calcInfo()
    }
    
    func setupTodaysDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        todaysDate.text = dateFormatter.string(from: today)
        datePicker.maximumDate = today
        
        calcInfo()
    }
    
    
    @IBAction func dateChanged(_ datePicker: UIDatePicker) {
        startDate = datePicker.date
        UserDefaults.standard.set(startDate, forKey: "StartDate")
        setupDate()
    }
    
    func setupInfo() {
        
        if staminaTotal == nil || staminaUsed == nil {
            staminaAmount.text = " ? / ? "
        } else {
            //values will only run if they aren't nill, so it should be safe
            let total = String(format: "%0.2f", staminaTotal!)
            let difference = staminaTotal! - staminaUsed!
            let left = String(format: "%0.2f", difference)
            staminaAmount.text = "\(left) / \(total)"
        }
        
    }
    
    func calcInfo() {
        let daysBetween = Calendar.current.dateComponents([.day], from: startDate, to: today)
        var days = daysBetween.day!
        
        //test
       // staminaLeft = 2000
        
        if staminaUsed != nil {
            
            // otherwise, shows up as infinite... either way, within the same day means that its within the day of spending
            if days == 0 {
                days = 1
            }
            
            let stamina = staminaUsed!
            
            let perDay = stamina / Double(days)
            let pDay = String(format: "%0.2f", perDay)
            
            let perWeek = perDay * 7
            let pWeek = String(format: "%0.2f", perWeek)
            
            stamPerDay.text = pDay
            stamPerWeek.text = "\(pWeek)"
            
            //calculate progression bar, total = 150
            let percentage = (staminaTotal! - staminaUsed!) / staminaTotal!
            let bar = (150 * percentage)
            
            progressBarWidth.constant = CGFloat(bar)
            
            
        }
        
        DaysSince.text = "\(days)"
        
    }
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    @IBAction func payDayTapped(_ sender: Any) {
        //set record of period,
        //input current day or ask user to input new day
    }
    
    
    

}
