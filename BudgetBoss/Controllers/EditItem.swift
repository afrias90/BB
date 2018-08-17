//
//  EditItem.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/16/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class EditItem: UIViewController {
    
    var category = ""
    
    @IBOutlet weak var assetHeight: NSLayoutConstraint!
    @IBOutlet weak var assetStackView: UIStackView!
    
    @IBOutlet weak var creditHeight: NSLayoutConstraint!
    @IBOutlet weak var creditStackView: UIStackView!
    
    @IBOutlet weak var afflictionHeight: NSLayoutConstraint!
    @IBOutlet weak var afflictionStackview: UIStackView!
    
    @IBOutlet weak var powerBtn: UIButton!
    @IBOutlet weak var magicBtn: UIButton!
    @IBOutlet weak var afflictionBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        reset()
    }

  
    @IBAction func powerPressed(_ sender: Any) {
        category = "power"
        selectedCategory(selection: category)
    }
    
    @IBAction func magicPressed(_ sender: Any) {
        category = "magic"
        selectedCategory(selection: category)
    }
    
    @IBAction func afflictionPressed(_ sender: Any) {
        category = "affliction"
        selectedCategory(selection: category)
    }
    
    //using button.imageView?.image instead of button.setImage... will lead to problems
    func selectedCategory(selection: String) {
        switch selection {
        case "power":
            self.view.layoutIfNeeded()
            resetMagic()
            resetAffliction()
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {
                
                self.assetHeight.constant = 60
                self.assetStackView.alpha = 1
                self.powerBtn.setImage(UIImage(named: "Power"), for: .normal)
            }, completion: nil)
            
            
            
        case "magic":
            self.view.layoutIfNeeded()
            resetPower()
            resetAffliction()
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {
                
                self.creditHeight.constant = 60
                self.creditStackView.alpha = 1
                self.magicBtn.setImage(UIImage(named: "Magic"), for: .normal)
            }, completion: nil)
            
            
            
        case "affliction":
            self.view.layoutIfNeeded()
            resetPower()
            resetMagic()
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {
                
                self.afflictionHeight.constant = 60
                self.afflictionStackview.alpha = 1
                self.afflictionBtn.setImage(UIImage(named: "Affliction"), for: .normal)
            }, completion: nil)
            
            
        default:
            print("row oh")
        }
        
        
        
    }
    
    func reset() {
        category = ""
        resetPower()
        resetMagic()
        resetAffliction()
    }
    
    func resetPower() {
        self.view.layoutIfNeeded()
        assetStackView.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveLinear], animations: {
            self.assetHeight.constant = 4
            
            self.powerBtn.setImage(UIImage(named: "unselectedPower"), for: .normal)
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    func resetMagic() {
        self.view.layoutIfNeeded()
        creditStackView.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveLinear], animations: {
            self.creditHeight.constant = 4
            
            self.magicBtn.setImage(UIImage(named: "unselectedMagic"), for: .normal)
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    func resetAffliction() {
        self.view.layoutIfNeeded()
        afflictionStackview.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveLinear], animations: {
            self.afflictionHeight.constant = 4
            
            self.afflictionBtn.setImage(UIImage(named: "unselectedAffliction"), for: .normal)
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    
    

}
