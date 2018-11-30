//
//  StatInfoVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/23/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class StatInfoVC: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var infoView: StatsView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var infoText: UITextView!
    
    
    var infoSelection: String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(StatInfoVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        // Do any additional setup after loading the view.
    }

    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if infoSelection != nil {
            setupInfo()
        } else {
            infoTitle.text = "Error"
        }
    }
    
    func setupInfo() {
        if infoSelection == "Power" {
            imageView.image = UIImage(named: "Power")
            infoView.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            infoText.text = powerInfo
            infoTitle.text = infoSelection!
            
        }
        if infoSelection == "Magic" {
            imageView.image = UIImage(named: "Magic")
            infoView.backgroundColor = #colorLiteral(red: 0.7374087881, green: 0.1608138372, blue: 0.7364352597, alpha: 1)
            infoText.text = magicInfo
            infoTitle.text = infoSelection!
        }
        if infoSelection == "Affliction" {
            imageView.image = UIImage(named: "Affliction")
            infoView.backgroundColor = #colorLiteral(red: 0.5290860095, green: 0.3688080318, blue: 0.7328068544, alpha: 1)
            infoText.text = afflictionInfo
            infoTitle.text = infoSelection!
        }
        if infoSelection == "Smithing" {
            imageView.image = UIImage(named: "Upgrades")
            infoView.backgroundColor = #colorLiteral(red: 0.7762513757, green: 0.5546936393, blue: 0.4039721489, alpha: 1)
            infoText.text = afflictionInfo
            infoTitle.text = infoSelection!
        }
        if infoSelection == "Cleanse" {
            imageView.image = UIImage(named: "Cleanse")
            infoView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            infoText.text = afflictionInfo
            infoTitle.text = infoSelection!
        }
        if infoSelection == "Sickness" {
            imageView.image = UIImage(named: "Sickness")
            infoView.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            infoText.text = afflictionInfo
            infoTitle.text = infoSelection!
        }
        if infoSelection == "Energy" {
            imageView.image = UIImage(named: "Energy")
            infoView.backgroundColor = #colorLiteral(red: 0.9636190534, green: 0.8843758106, blue: 0.2107867897, alpha: 1)
            infoText.text = afflictionInfo
            infoTitle.text = infoSelection!
        }
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    var powerInfo = "Power is determined by your assets - anything that has a positive value such as money in your bank account, cash, or property."
    var magicInfo = "Magic is determined by your credit-line - 'fake money'. Be careful as using magic only turns into debt/affliction."
    var afflictionInfo = "Affliction is determined by your debt. The more debt you are the more you are afflicted. This will come in the form of fees, loans, and credit card debt."
    
    var smithInfo = "Smithing is determined by how much money you put away (save) from your main spending account (first item in your inventory)."
    var cleanseInfo = "Cleanse is determined by debt paid down."
    var sicknessInfo = "Sickness is determined when you're afflicted with any new debt. This can include fees, debt acrruing in credit debt or loans."
    var energyInfo = "Energy is determined by additional income. This can include finding money, getting gift money, or addtional work pay."

}
