//
//  BudgetTVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 10/24/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class BudgetTVC: UITableViewController, BudgetXibDelegate {
    
    @IBOutlet weak var abilityInfo: UITextView!
    
    
    func budgetXibVCDidCancel(_ controller: BudgetVC) {
        dismiss(animated: true, completion: nil)
    }
    
    func budgetXibVC(_ controller: BudgetVC, didFinishEditing budget: Double, for Ability: String) {
        print("This is our returned set ability \(Ability)")
        if Ability == "Attack" {
            let attack = "AttackBudget"
            UserDefaults.standard.set(budget, forKey: attack)
        } else if Ability == "Defense" {
            let defense = "DefenseBudget"
            UserDefaults.standard.set(budget, forKey: defense)
        }
        
        setupInfo()
    }
    
    var abilityTitle: String?
    
    var abilityTotal: Double?
    
    //obtained from the previous controller
    var abilityUsed: Double?
    
    @IBOutlet weak var budgetAmount: UILabel!
    @IBOutlet weak var budgetProgressWidth: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if abilityTitle != nil {
            title = abilityTitle!
        }

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupInfo()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    @IBAction func closedTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func editTapped(_ sender: Any) {
        let budgetView = BudgetVC()
        budgetView.delegate = self
        budgetView.budgetAbility = abilityTitle!
        budgetView.modalPresentationStyle = .custom
        present(budgetView, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func setupInfo() {
        
        var ability = ""
        if abilityTitle == "Attack" {
            ability = "AttackBudget"
            abilityInfo.text = attackInfo
            
        } else {
            ability = "DefenseBudget"
            abilityInfo.text = defenseInfo
        }
        
        abilityTotal = UserDefaults.standard.double(forKey: ability)
        
        if abilityTotal == nil || abilityUsed == nil {
            budgetAmount.text = " ? / ? "
        } else {
            //values will only run if they aren't nill, so it should be safe
            let total = String(format: "%0.2f", abilityTotal!)
            let difference = abilityTotal! - abilityUsed!
            let left = String(format: "%0.2f", difference)
            budgetAmount.text = "\(left) / \(total)"
        }
        
    }
    
    let attackInfo = "Attack refers to your budget for Priorities. This includes necessary, known, or repeating expenses such as groceries, utility bills, etc. You earned this money, but life requires much upkeep (less if you move off the grid!)"
    let defenseInfo = "Defense refers to your budget for entertainment or just about any other miscellaneous like that cool beanie you'll wear a few times or keychain from that state you visited. Keep your defense up!"
    
    
    
    
    
    
    

}
