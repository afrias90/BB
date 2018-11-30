//
//  ProgressVC.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/28/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import CoreData

class ProgressVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var character: Character!
    var progressList: [Progress] = []
    @IBOutlet weak var progressTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        progressTableView.delegate = self
        progressTableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchProgressReports()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if progressList.count > 0 {
            return progressList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if progressList.count > 0 {
            if let cell = progressTableView.dequeueReusableCell(withIdentifier: "progressCell") as? ProgressCell {
                let report = progressList[indexPath.row]
                cell.configureProgressCell(character: character, progress: report)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
  
    func fetchProgressReports() {
        do {
            let results = try context.fetch(Progress.fetchRequest()) as [Progress]
            if results.count > 0 {
                progressList = results.reversed()
            }
        } catch let error as NSError {
            print(error)
        }
    }

}
