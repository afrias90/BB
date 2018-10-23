//
//  StaminaVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/12/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class StaminaXibVC: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var textfield: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(StaminaXibVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }

    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setStaminaPressed(_ sender: Any) {
        
    }
    
    @IBAction func paydayPressed(_ sender: Any) {
    }
    
    
    func fetch() {
        
    }
    

}
