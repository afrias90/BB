//
//  StatsVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/10/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class StatsVC: UIViewController, UINavigationControllerDelegate {
    
    //instantiating settings here? correct/okay method? others?
    var settings: Settings!
    
    var character: Character?
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var playerClassLbl: UILabel!
    
    @IBOutlet weak var totalStaminaAmt: UILabel!
    @IBOutlet weak var staminaProgressWidth: NSLayoutConstraint!
    @IBOutlet weak var staminaLeftLabel: UILabel!
    
    
    @IBOutlet weak var powerAmt: UILabel!
    @IBOutlet weak var magicAmt: UILabel!
    @IBOutlet weak var afflictionAmt: UILabel!
    
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    
    //Budget Progress bars
    @IBOutlet weak var attProgressView: UIView!
    @IBOutlet weak var attProgressContraint: NSLayoutConstraint!
    @IBOutlet weak var defProgressView: UIView!
    @IBOutlet weak var defProgressContraint: NSLayoutConstraint!
    
    @IBOutlet weak var upgradesAmt: UILabel!
    @IBOutlet weak var cleanseAmt: UILabel!
    @IBOutlet weak var sicknessAmt: UILabel!
    @IBOutlet weak var energyAmt: UILabel!
    
    // calculated values
    var power = 0.0
    var magic = 0.0
    var affliction = 0.0
    var spendingAttack = 0.0
    var spendingDefense = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if character == nil {
            //fetches player or sends player to character creation
            fetchPlayer()
        } else {
            // we can update things
            let stamina = String(format: "%0.2f", UserDefaults.standard.double(forKey: "TotalStamina"))
            if totalStaminaAmt.text != stamina {
                totalStaminaAmt.text = stamina
                
            }
            //changes in att and def here
            setupPlayer(character: character!)
            calcStaminaProgressBar()
            calculatePMA()
        }
        
    }
    
    @IBAction func staminaPressed(_ sender: Any) {
//        let staminaView = StaminaVC()
//        staminaView.modalPresentationStyle = .custom
//        present(staminaView, animated: true, completion: nil)
        performSegue(withIdentifier: "staminaSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "staminaSegue" {
            let controller = segue.destination as! StaminaTVC
            if character != nil {
                controller.staminaUsed = character?.stamina
            } else {
                //character hasn't been created and someone clicked on stamina? who knows!
            }
        } else if segue.identifier == "attackSegue" {
            let controller = segue.destination as! BudgetTVC
            controller.abilityTitle = "Attack"
            controller.abilityUsed = character?.attack
            
            
        } else if segue.identifier == "defenseSegue" {
            let controller = segue.destination as! BudgetTVC
            controller.abilityTitle = "Defense"
            controller.abilityUsed = character?.defense
        }
        
    }
    
    @IBAction func attackPressed(_ sender: Any) {
        performSegue(withIdentifier: "attackSegue", sender: nil)
    }
    
    @IBAction func defensePressed(_ sender: Any) {
        performSegue(withIdentifier: "defenseSegue", sender: nil)
    }
    
    func fetchPlayer() {
        
        do {
            
            //is it ok to have the context globally available like this? is not, what's safer?
            let results = try context.fetch(Character.fetchRequest()) as [Character]
            if results.count > 0 {
                
                //if multiple saves added later, this will have to be changed
                character = results.first
                setupPlayer(character: character!)
                //print(character?.attack, character?.defense, character?.affliction, character?.name)
            } else {
                print("No characters found")
                performSegue(withIdentifier: "createCharacter", sender: nil)
            }
            
        } catch {
            let error = error as NSError
            print(error)
        }
    
    }
    
    func setupPlayer(character: Character) {
        //called after player fetched and found
        
        nameLbl.text = character.name
        totalStaminaAmt.text = "/\(String(format: "%0.2f", UserDefaults.standard.double(forKey: "TotalStamina")))"
        //staminaAmt.text = String(format: "%0.2f", character.stamina)

//        magicAmt.text =
//        afflictionAmt.text =
        
        let attack = UserDefaults.standard.double(forKey: "AttackBudget")
        let defense = UserDefaults.standard.double(forKey: "DefenseBudget")
        let attackUsed = character.attack
        let defenseUsed = character.defense
        
        let attackBudget = String(format: "%0.2f", attack)
        let defenseBudget = String(format: "%0.2f", defense)
        
        
        
        let attackDiff = attack - attackUsed
        let attackProgress = (attackDiff * 100) / attack
        let defenseDiff = defense - defenseUsed
        let defenseProgress = (defenseDiff * 100) / defense
        
        let attackUsedString = String(format: "%0.2f", attackDiff)
        let defenseUsedString = String(format: "%0.2f", defenseDiff)
        
        attackLabel.text = "\(attackUsedString)/ \(attackBudget)"
        defenseLabel.text = "\(defenseUsedString)/ \(defenseBudget)"
        
        
        //when att/def is still set to zero, dividing for percetange will result in NaN for the double-values
        if attackProgress.isNaN {
            attProgressContraint.constant = 0
        } else {
            attProgressContraint.constant = CGFloat(attackProgress)
        }
        
        if defenseProgress.isNaN {
            defProgressContraint.constant = 0
        } else {
            defProgressContraint.constant = CGFloat(defenseProgress)
        }
        
        //
        calcStaminaProgressBar()
        //set up notification for progress bar?
        calculatePMA()
    }
    
    func calcStaminaProgressBar() {
        //clean up later...
        
        let totalStamina = UserDefaults.standard.double(forKey: "TotalStamina")
        let staminaUsed = character?.stamina
        
        let difference = totalStamina - staminaUsed!
        staminaLeftLabel.text = String(format: "%0.2f", difference)
        let percentage = difference / totalStamina
        let progressBar = 100 * percentage
        staminaProgressWidth.constant = CGFloat(progressBar)
        
    }
    
    func calculatePMA() {
        // debt, credit, asset
        let items = character?.item?.array as! [Item]
        var pow = 0.0
        var mag = 0.0
        var aff = 0.0
        
        for item in items {
            if item.category == "asset" {
                pow += item.value
            } else if item.category == "credit" {
                mag += item.durability
                //defined by debt == true
                aff += item.value
            } else if item.category == "debt" {
                //defined by debt == true
                aff += item.value
            }
            
        }
        
        powerAmt.text = String(format: "%0.2f", pow)
        magicAmt.text = String(format: "%0.2f", mag)
        afflictionAmt.text = String(format: "%0.2f", aff)
        
    }
    
    
    
}

