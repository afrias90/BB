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

        // Do any additional setup after loading the view.
    }

   
    override func viewWillAppear(_ animated: Bool) {
        fetch()
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
                print("print \(items[0].name)")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
