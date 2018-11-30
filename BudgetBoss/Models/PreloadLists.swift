//
//  PreloadLists.swift
//  BudgetBoss
//
//  Created by Adolfo Frias on 11/22/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import Foundation



func preload() {
    
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

var moveList: [Move] = []
func preloadMoveList() {
    
    for (name, alias) in preloadedMoves {
        let move = Move(context: context)
        move.name = name
        move.actualName = alias
        moveList.append(move)
    }
    assignCategoriesToMoves()
    ad.saveContext()
}

func preloadCategories() {
    for cat in preloadedCategories {
        let newCat = ObjCategory(context: context)
        newCat.name = cat
    }
    //will this save all the new items? yes!
    ad.saveContext()
}


func assignCategoriesToMoves() {
    do {
        let results = try context.fetch(ObjCategory.fetchRequest()) as [ObjCategory]
        for cat in results {
            for move in moveList {
                if cat.name == "Mortgage/Rent" && move.actualName == "Rent" {
                    cat.addToMove(move)
                }
                if cat.name == "Food/Dining" && move.actualName == "Lunch" {
                    cat.addToMove(move)
                }
                if cat.name == "Utility" && move.actualName == "Electric Bill" {
                    cat.addToMove(move)
                }
                if cat.name == "Internet" && move.actualName == "Internet Bill" {
                    cat.addToMove(move)
                }
                if cat.name == "Junk Food" && move.actualName == "Candy" {
                    cat.addToMove(move)
                }
            }
        }
        
    } catch let error as NSError {
        print(error)
    }
    ad.saveContext()
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

var preloadedMoves: [String:String] = [
    "Chains of Comfort":"Rent",
    "Thunderbolt":"Electric Bill",
    "High Fructosity":"Candy",
    "Knowledge Calamity":"Internet Bill",
    "Endless Menu":"Lunch"
]










