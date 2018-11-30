//
//  MoveListVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/4/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class MoveListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var moveTableView: UITableView!
    
    var selectedMove: Move?
    var moveList: [Move] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        moveTableView.delegate = self
        moveTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMoveList()
        moveTableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moveList.count > 0 {
            return moveList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if moveList.count > 0 {
            let cell = moveTableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath) as! ObjectCell
            let move = moveList[indexPath.row]
            cell.configureMoveCell(move: move)
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "There is an error"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMove = moveList[indexPath.row]
        performSegue(withIdentifier: "editMoveSegue", sender: selectedMove)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editMoveSegue" {
            if let destination = segue.destination as? EditMoveVC {
                destination.moveToEdit = sender as? Move
            }
        }
    }
    
    func fetchMoveList() {
        do {
           let results = try context.fetch(Move.fetchRequest()) as [Move]
            if results.count > 0 {
                moveList = results
            } else {
//                preloadMoveList()
            }
        } catch let error as NSError {
            print("MoveListVC: \(error)")
        }
    }
    
    
    
    
  
//    "Mortgage/Rent",
//    "Food/Dining",
//    "Utility",
//    "Internet",
//    "Junk Food"
    
//    "Chains of Comfort":"Rent",
//    "Thunderbolt":"Electric Bill",
//    "High Fructosity":"Candy",
//    "Knowledge Calamity":"Internet Bill",
//    "Endless Menu":"Lunch"
    
    
    
}
