//
//  Settings.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 10/22/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import Foundation

struct Settings {
    
    var startDate: Date {
        get {
            return UserDefaults.standard.object(forKey: "StartDate") as! Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "StartDate")
        }
    }
    
    var totalStamina: Double {
        get {
            return UserDefaults.standard.double(forKey: "TotalStamina")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "TotalStamina")
        }
    }
    
    init() {
        registerDefaults()
        firstLoad()
    }
    
    func registerDefaults() {
        //add any first time items here as well
        //date has to be initiated?
        let dictionary: [String:Any] = ["FirstTime": true, "StartDate": Date(), "TotalStamina": 0.00 ] as [String:Any]
        UserDefaults.standard.register(defaults: dictionary)
        
    }
    
    mutating func firstLoad() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        if firstTime {
            startDate = Date()
            
            userDefaults.set(false, forKey: "FirstTime")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
