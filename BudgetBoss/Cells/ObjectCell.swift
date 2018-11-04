//
//  ObjectCell.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/4/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class ObjectCell: UITableViewCell {
    
    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var actualMoveNameLabel: UILabel!
    @IBOutlet weak var moveCatLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureMoveCell(move: Move) {
        moveNameLabel.text = move.name
        actualMoveNameLabel.text = move.actualName
        moveCatLabel.text = move.category?.name ?? ""
    }
    
    

}
