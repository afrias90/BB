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
    
    override func viewDidAppear(_ animated: Bool) {
        if character == nil {
            //fetches player or sends player to character creation
            fetchPlayer()
        }
    }
    
    @IBAction func staminaPressed(_ sender: Any) {
//        let staminaView = StaminaVC()
//        staminaView.modalPresentationStyle = .custom
//        present(staminaView, animated: true, completion: nil)
        performSegue(withIdentifier: "staminaSegue", sender: nil)
    }
    
    @IBAction func attackPressed(_ sender: Any) {
        
    }
    
    @IBAction func defensePressed(_ sender: Any) {
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
        totalStaminaAmt.text = String(format: "%0.2f", UserDefaults.standard.double(forKey: "TotalStamina"))
        //staminaAmt.text = String(format: "%0.2f", character.stamina)

//        magicAmt.text =
//        afflictionAmt.text =
        
        let attack = String(format: "%0.2f", character.attack)
        let defense = String(format: "%0.2f", character.defense)
        
        attackLabel.text = "\(0)/ \(attack)"
        defenseLabel.text = "\(0)/ \(defense)"
    
        attProgressContraint.constant = 0
        defProgressContraint.constant = 0
        
        
        //set up notification for progress bar?
    }
    
    
    
    
}

