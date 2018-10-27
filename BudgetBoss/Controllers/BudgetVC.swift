//
//  BudgetVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 10/24/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

protocol BudgetXibDelegate: class {
    func budgetXibVCDidCancel(_ controller: BudgetVC)
    func budgetXibVC(_ controller: BudgetVC, didFinishEditing budget: Double, for Ability: String)
}

class BudgetVC: UIViewController {
    
    var delegate: BudgetXibDelegate?
    var budgetAbility: String?
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var xibBudgetTitle: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var statsView: StatsView!
    @IBOutlet weak var setAbilityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if budgetAbility != nil {
            if let budget = budgetAbility {
                if budget == "Attack" {
                    xibBudgetTitle.text = budget
                    statsView.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    xibBudgetTitle.text = "Attack"
                    setAbilityButton.setTitleColor(#colorLiteral(red: 0.6789039373, green: 0.03930729628, blue: 0.04283870012, alpha: 1), for: .normal)
                    setAbilityButton.setTitle("Set Attack", for: .normal)
                } else if budget == "Defense" {
                    xibBudgetTitle.text = budget
                    statsView.backgroundColor = #colorLiteral(red: 0.107016407, green: 0.5467073917, blue: 1, alpha: 1)
                    xibBudgetTitle.text = "Defense"
                    setAbilityButton.setTitleColor(#colorLiteral(red: 0.07881248742, green: 0.3584259152, blue: 0.6794278026, alpha: 1), for: .normal)
                    setAbilityButton.setTitle("Set Defense", for: .normal)
                }
            }
        }
        
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(BudgetVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        textfield.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func setAbilityTapped(_ sender: Any) {
        if let ability = Double(textfield.text!) {
            delegate?.budgetXibVC(self, didFinishEditing: ability, for: budgetAbility!)
            dismiss(animated: true, completion: nil)
        } else {
            
        }
    }
    
    

}
