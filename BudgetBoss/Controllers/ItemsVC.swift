//
//  ItemsVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 8/15/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class ItemsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //variables
    var character: Character?
    var items = [Item]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

   
    override func viewWillAppear(_ animated: Bool) {
        fetch()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //save when return is pressed
    }
    
    @IBAction func newItemPressed(_ sender: Any) {
        
    }
    
    func fetch() {
        do {
            let results = try context.fetch(Character.fetchRequest()) as [Character]
            if results.count > 0 {
                character = results.first
                items = character?.item?.array as! [Item]
            }
                
        } catch {
                
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count > 0 {
            return items.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath) as? ItemCell {
            let item = items[indexPath.row]
            cell.configureCell(item: item)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check segue identifier and destination (VC)
        if segue.identifier == "editItem" {
            if let destination = segue.destination as? EditItem {
                if let item = sender as? Item {
                    //send item selected and player
                    destination.itemToEdit = item
                    destination.player = character
                    print("Item sent over: \(item)")
                }
            }
        }
        if segue.identifier == "createItem" {
            if let destination = segue.destination as? EditItem {
                destination.player = character
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = items[indexPath.row]
        performSegue(withIdentifier: "editItem", sender: selection)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
