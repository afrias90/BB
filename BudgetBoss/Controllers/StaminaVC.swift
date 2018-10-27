//
//  StaminaVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/12/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

protocol StaminaXibVCDelegate: class {
    func staminaXibVCDidCancel(_ controller: StaminaVC)
    func staminaXibVC(_ controller: StaminaVC, didFinishEditing stamina: Double)
}

class StaminaVC: UIViewController {
    
    //not sure if this is enough to get the delegate to work...
    var delegate: StaminaXibVCDelegate?
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var textfield: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(StaminaVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        textfield.becomeFirstResponder()
    }

    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setStaminaPressed(_ sender: Any) {
        
        if let stamina = Double(textfield.text!) {
            delegate?.staminaXibVC(self, didFinishEditing: stamina)
            dismiss(animated: true, completion: nil)
        } else {
            
        }
        
        
    }
    
   
    
    func fetch() {
        
    }
    

}
