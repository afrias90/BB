//
//  CatListVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/4/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class CatListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var catTableView: UITableView!
    //categories preloaded in previous screen
    
    var catList: [ObjCategory] = []
    var selectedCat: ObjCategory?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        catTableView.delegate = self
        catTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCatList()
        catTableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if catList.count > 0 {
            return catList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if catList.count > 0 {
            let cell = catTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CatCell
            let cat = catList[indexPath.row]
            cell.configureCatCell(cat: cat)
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "There is an error"
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCat = catList[indexPath.row]
        performSegue(withIdentifier: "editCatSegue", sender: selectedCat)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editCatSegue" {
            if let destination = segue.destination as? EditCatVC {
                destination.catToEdit = sender as? ObjCategory
            }
        }
    }
    
    
    func fetchCatList() {
        do {
            let results = try context.fetch(ObjCategory.fetchRequest()) as [ObjCategory]
            if results.count > 0 {
                catList = results
            } else {
                print("We didn't load any category list! Ruuunnnn!!!")
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    
    
    
    
    
    
    

}
