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
                    var summary = ""
                    if firstLog != nil {
                        summary = (firstLog?.detail)!
                    } else {
                        summary = "We can't find any recent record"
                    }
                    
                    cell.configureSummaryCell(summary: summary)
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
        if indexPath.section == 0 {
            performSegue(withIdentifier: "logSegue", sender: nil)
        }
        // selecting actions
        if indexPath.section == 1 {
            let action = actions[indexPath.row]
            performSegue(withIdentifier: "actionSegue", sender: action)
        }
        
        // selecting lists
        if indexPath.section == 2 {
            //update this when lists are done
            if lists[indexPath.row] == "Targets" {
                performSegue(withIdentifier: "targetListSegue", sender: nil)
            } else if lists[indexPath.row] == "Moves" {
                performSegue(withIdentifier: "moveListSegue", sender: nil)
            } else if lists[indexPath.row] == "Categories" {
                performSegue(withIdentifier: "categoryListSegue", sender: nil)
            }
            
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
        }
//        } else if segue.identifier == "listSegue" {
//            if let destination = segue.destination as? TargetListVC {
//                if let list = sender as? String {
//                    destination.listName = list
//                    print("List chosen: \(list)")
//                }
//            }
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchFirstLog()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //first view that can lead to categories (i think)
        // check to see if there are any, if not, population preloadedCategories
        fetchPreloads()
        
    }
    
    func fetchPreloads() {
        do {
            let results = try context.fetch(ObjCategory.fetchRequest()) as [ObjCategory]
            if results.isEmpty {
                preloadCategories()
            }
            
        } catch let error as NSError {
            print(error)
        }
        
        do {
            let results = try context.fetch(Merchant.fetchRequest()) as [Merchant]
            if results.count > 0 {
                
            } else {
                preloadTargetList()
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    var firstLog: Log?
    func fetchFirstLog() {
        do {
            let results = try context.fetch(Log.fetchRequest()) as [Log]
            if results.count > 0 {
                firstLog = results.last
                print("First log: \(firstLog)")
            } else {
                
                
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    var preloadedTargets: [String:String] = [
        "Lord of the Land":"Land Lord",
        "Glutaneous Vegetation":"Grocery Market",
        "Electrode":"Electricity"
    ]
    
    var preloadedCategories = [
    "Mortgage/Rent",
    "Food/Dining",
    "Utility",
    "Internet",
    "Junk Food"
    ]
    
    func preloadCategories() {
        for cat in preloadedCategories {
            let newCat = ObjCategory(context: context)
            newCat.name = cat
        }
        //will this save all the new items? yes!
        ad.saveContext()
    }
    
    func preloadTargetList() {
        var targetList: [Merchant] = []
        for (name,alias) in preloadedTargets {
            //create target with name from preloaded targets
            let target = Merchant(context: context)
            target.name =  name
            target.actualName = alias
            targetList.append(target)
        }
        
        ad.saveContext()
        
    }
    
    


}
