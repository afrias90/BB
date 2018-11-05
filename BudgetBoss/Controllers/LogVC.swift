//
//  LogVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/4/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class LogVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var logTableView: UITableView!
    
    var logBook: [Log] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logTableView.delegate = self
        logTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTheLogYaaargh()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if logBook.count > 0 {
            return logBook.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if logBook.count > 0 {
            if let cell = logTableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as? LogCell {
                let log = logBook[indexPath.row]
                cell.configureLogCell(log: log)
                return cell
            }
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "There is nothing in the logbook"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func fetchTheLogYaaargh() {
        do {
            let results = try context.fetch(Log.fetchRequest()) as [Log]
            if results.count > 0 {
                logBook = results
            }
        } catch let error as NSError {
            print(error)
        }
    }
    

    

}
