//
//  SummaryCell.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 10/31/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class SummaryCell: UITableViewCell {
    
    @IBOutlet weak var summaryText: UITextView!
    

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func configureSummaryCell(summary: String?) {
        if summary != nil {
            summaryText.text = summary!
            
        } else {
            summaryText.text = "I have no idea what you were doing previously"
            
        }
       
    }
    
    
    

}
