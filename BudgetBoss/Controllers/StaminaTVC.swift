//
//  StaminaTVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 10/20/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData


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
    }
    //stored in userdefaults
    var staminaTotal: Double?
    //obtained from the previous controller
    //var staminaUsed: Double?
    
    // variables
    var today = Date()
    var startDate = Date()
    var datepickerHidden = true
    var character: Character?
    
    var smith = 0.0
    var cleanse = 0.0
    var sickness = 0.0
    var energy = 0.0
    
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
        
        if staminaTotal == nil || character == nil {
            staminaAmount.text = " ? / ? "
        } else {
            //values will only run if they aren't nill, so it should be safe
            let total = String(format: "%0.2f", staminaTotal!)
            let difference = staminaTotal! - (character?.stamina)!
            let left = String(format: "%0.2f", difference)
            staminaAmount.text = "\(left) / \(total)"
            
            let percentage = (staminaTotal! - (character?.stamina)!) / staminaTotal!
            let staminaProgress = (percentage * 150)
            
            if staminaProgress.isNaN || staminaProgress < 0 {
                progressBarWidth.constant = 0
            } else {
                progressBarWidth.constant = CGFloat(staminaProgress)
            }
            
            
        }
    }
    
    func calcInfo() {
        let daysBetween = Calendar.current.dateComponents([.day], from: startDate, to: today)
        var days = daysBetween.day!
        if character != nil {
            // otherwise, shows up as infinite... either way, within the same day means that its within the day of spending
            if days == 0 {
                days = 1
            }
            
            let stamina = character?.stamina
            
            let perDay = stamina! / Double(days)
            let pDay = String(format: "%0.2f", perDay)
            
            let perWeek = perDay * 7
            let pWeek = String(format: "%0.2f", perWeek)
            
            stamPerDay.text = pDay
            stamPerWeek.text = "\(pWeek)"
            
            //calculate progression bar, total = 150
            let percentage = (staminaTotal! - stamina!) / staminaTotal!
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
        let ac = UIAlertController(title: "New Pay Period", message: "Are you sure you want to record stats and start new pay period?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "RESTART", style: .destructive, handler: { Void in
            assert(self.character != nil)
            self.fetchConvertLogs()
            self.createProgressReport()
            
            self.character?.attack = 0
            self.character?.defense = 0
            self.character?.stamina = 0
            UserDefaults.standard.set(self.today, forKey: "StartDate")
            
            //set logs to current = false
            
            
            ad.saveContext()
            
            
            self.navigationController?.popViewController(animated: true)
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(cancelAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    
    func fetchConvertLogs(){
        do {
            
            let results = try context.fetch(Log.fetchRequest()) as [Log]
            if results.count > 0 {
                for result in results {
                    if result.current {
                        
                        if result.current {
                            if result.category == "Smith" {
                                smith += result.power
                            } else if result.category == "Cleanse" {
                                cleanse += result.power
                            } else if result.category == "Sickness" {
                                sickness += result.power
                            } else if result.category == "Energy" {
                                energy += result.power
                            }
                        }
                        result.current = false
                    }
                    
                }
                ad.saveContext()
            }
            
        } catch let error as NSError {
            print("print: \(error)")
        }
    }
    
    func createProgressReport() {
        var pp = 0
        var multiplier = 1
        
        let stamina = UserDefaults.standard.double(forKey: "TotalStamina")
        let staminaUsed = (character?.stamina)!
        let staminaLeft = stamina - staminaUsed
        let percentage = Int((staminaLeft / stamina) * 100)
        let staminaTens = percentage / 10
        print("percentage divided by 10: \(staminaTens)")
        
        if percentage >= 0 {
            if character?.charClass == "watchman" {
                multiplier = 3
            }
            pp += (1 * multiplier)
            if staminaTens > 0 {
                pp += (staminaTens * multiplier)
            }
            //reset multiplier
            multiplier = 1
        }
        
        let attack = UserDefaults.standard.double(forKey: "AttackBudget")
        let attackUsed = (character?.attack)!
        
        
        let attackLeft = attack - attackUsed
        
        //
        var attPercentage = 0
        if attack == 0 {
            
        } else {
            attPercentage = Int((attackLeft / attack) * 100)
        }
        let attTens = attPercentage / 10
        print("att: \(attTens)")
        if attPercentage >= 0 {
            if character?.charClass == "fighter" {
                multiplier = 3
            }
            pp += (1 * multiplier)
            if attTens > 0 {
                pp += (attTens * multiplier)
            }
            multiplier = 1
        }
        print("pp:\(pp)")
        
        let defense = UserDefaults.standard.double(forKey: "DefenseBudget")
        let defenseUsed = (character?.defense)!
        let defenseLeft = defense - defenseUsed
        
        var defPercentage = 0
        if defense == 0 {
            
        } else {
            defPercentage = Int((defenseLeft / defense) * 100)
        }
        
        let defTens = defPercentage / 10
        if defPercentage >= 0 {
            if character?.charClass == "guardian" {
                multiplier = 3
            }
            pp += 1
            if defTens > 0 {
                pp += defTens
            }
            multiplier = 1
        }
        print("pp:\(pp)")
        
        //need to fix points and assign
        let smithPercentage = Int((smith / stamina) * 100)
        let smithTens = smithPercentage / 10
        if smithPercentage >= 0 {
            if character?.charClass == "blacksmith" {
                multiplier = 3
            }
            pp += 1
            if smithPercentage > 0 {
                pp += smithTens
            }
            multiplier = 1
        }
        print("pp:\(pp)")
        
        let cleansePercentage = Int((cleanse / stamina) * 100)
        let cleanseTens = cleansePercentage / 10
        if cleansePercentage >= 0 {
            if character?.charClass == "Cursed Warrior" {
            multiplier = 3
            }
            pp += 1
            if cleansePercentage > 0 {
                pp += cleanseTens
            }
            multiplier = 1
        }
        print("pp:\(pp)")
        
        let sicknessPercentage = Int((sickness / stamina) * 100)
        let sicknessFive = sicknessPercentage / 5
        if sicknessPercentage >= 0 {
            pp -= 1
            if sicknessPercentage > 0 {
                pp -= sicknessFive
            }
        }
        print("pp:\(pp)")
        
        let energyPercentage = Int((energy / stamina) * 100)
        let energyTens = energyPercentage / 10
        if energyPercentage >= 0 {
            if character?.charClass == "joat" {
                multiplier = 3
            }
            pp += 1
            if energyPercentage > 0 {
                pp += energyTens
            }
            multiplier = 1
        }
        print("pp:\(pp)")
        
        character?.progress += Double(pp)
        
        let progress = Progress(context: context)
        progress.totalStamina = stamina
        progress.totalAttack = attack
        progress.totalDefense = defense
        progress.points = Double(pp)
        progress.stamina = staminaLeft
        progress.attack = attackLeft
        progress.defense = defenseLeft
        progress.smith = smith
        progress.cleanse = cleanse
        progress.sickness = sickness
        progress.energy = energy
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        let to = dateFormatter.string(from: today)
        let from = dateFormatter.string(from: startDate)
        progress.period = "\(from) - \(to)"
        
        
    }
    
    

}
