//
//  ListVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/1/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class TargetListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var targetTableView: UITableView!
    
    
    var selectedTarget: Merchant?
    var targetList: [Merchant] = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        targetTableView.delegate = self
        targetTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       fetchTargetList()
        targetTableView.reloadData()
    }
    
    //tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if targetList.count > 0 {
            return targetList.count
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if targetList.count > 0 {
            let cell = targetTableView.dequeueReusableCell(withIdentifier: "targetCell", for: indexPath) as! TargetCell
            let target = targetList[indexPath.row]
            cell.configureTargetCell(target: target)
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "There is an error"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTarget = targetList[indexPath.row]
        performSegue(withIdentifier: "editTargetSegue", sender: selectedTarget)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "editTargetSegue" {
            if let destination = segue.destination as? EditTargetVC {
                destination.targetToEdit = sender as? Merchant
            }
        }
    }
    
    

    func fetchTargetList() {
        do {
            let results = try context.fetch(Merchant.fetchRequest()) as [Merchant]
            if results.count > 0 {
                targetList = results
            } else {
                //preloadTargetList()
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    

}
