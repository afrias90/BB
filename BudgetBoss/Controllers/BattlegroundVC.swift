//
//  BattlegroundVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 10/31/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class BattlegroundVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var actions = [
    "Attack",
    "Defend",
    "Upgrade",
    "Cleanse",
    "Sickness",
    "Energy"
    ]
    
    var lists = [
    "Targets",
    "Moves",
    "Categories"
    ]
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        if indexPath.section == 1 {
            return 100
        }
        if indexPath.section == 2 {
            return 100
        }
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return actions.count
        }
        if section == 2 {
            //test for now
            return lists.count
        }
        return 0
    }
    
    
    
    
    
    var testString = "TEST Lord of the Land has appeared. They use Chains of Comfort (Rent)! You strike with Sword of Hope for 522.50 damage!... You have defeated a strong opponent (20% of stamina!). TEST"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as? SummaryCell {
//                let item = items[indexPath.row]
                    cell.configureSummaryCell(summary: testString)
                    return cell
            
            }
        }   else if indexPath.section == 1 {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "actionCell", for: indexPath) as? ActionCell {
                        let action = actions[indexPath.row]
                        cell.configureActionCell(action: action)
                        return cell
                    }
                    
            
        } else if indexPath.section == 2 {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "editingCell", for: indexPath) as? EditingCell {
                        let list = lists[indexPath.row]
                        cell.configureListCell(list: list)
                        return cell
                    }
        }
        
        return UITableViewCell()
    }

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = BattlegroundCellView()
        headerView.topColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerView.bottomColor = #colorLiteral(red: 0.5955198407, green: 0.5954543948, blue: 0.5899855494, alpha: 1)
        headerView.cornerRadius = 2
        headerView.borderWidth = 2
        headerView.alpha = 0.75
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        label.font = UIFont(name: "Futura", size: 20)
        //label.backgroundColor = UIColor.clear
        label.center = CGPoint(x: ((view.frame.width / 2 ) + 10), y: 15)
        
        if section == 0 {
            label.text = "Summary"
        }
        if section == 1 {
            label.text = "Actions"
        }
        if section == 2 {
            label.text = "Lists"
        }
        
        
        //headerView.backgroundColor = UIColor.gray
        headerView.addSubview(label)
        

        return headerView
    }
    

//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // selecting actions
        if indexPath.section == 1 {
            let action = actions[indexPath.row]
            performSegue(withIdentifier: "actionSegue", sender: action)
        }
        
        // selecting lists
        if indexPath.section == 2 {
            //update this when lists are done
            let list = lists[indexPath.row]
            performSegue(withIdentifier: "listSegue", sender: list)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "actionSegue" {
            if let destination = segue.destination as? ActionVC {
                if let action = sender as? String {
                    //send item selected and player
                    destination.actionName = action
                    print("Action chosen: \(action)")
                }
            }
        } else if segue.identifier == "listSegue" {
            if let destination = segue.destination as? ListVC {
                if let list = sender as? String {
                    destination.listName = list
                    print("List chosen: \(list)")
                }
            }
        }
    }


}
