//
//  ListCell.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 10/31/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class EditingCell: UITableViewCell {
    
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var listDescript: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func configureListCell(list: String?) {
        switch list {
        case "Targets":
            listName.text = "Targets"
            listDescript.text = "Name of service/merchant/seller"
        case "Moves":
            listName.text = "Moves"
            listDescript.text = "Give the things that cost you big a scary name!"
        case "Categories":
            listName.text = "Categories"
            listDescript.text = "purchase (moves) categories."
        default:
            print("we have a problem big chief")
        }
    
    }
    
    
    
    
    
    
}
