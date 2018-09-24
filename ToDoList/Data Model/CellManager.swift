//
//  AddAction.swift
//  ToDoList
//
//  Created by MSadri on 9/19/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
class CellManager {
    
    let defaults = UserDefaults.standard
    let firstPhraseKey  : String = "firstPhrase"
    let secondPhraseKey : String = "secondPhrase"
    
    var storageArray        = [CelliTem]()
    var titleKeeper         = [String]()
    var descriptionKeepr    = [String]()
    var stateKeeper         = [Bool]()
    
    // a refrence to keeper array will be here to access the data
    
    static let sharedObject = CellManager() 
    
    private init() {
        print("I am created")
    }
    //---------------------------------------------------------------------
    
    
    func fetchDataFromPListToCellManager() {
        
        /* if plist keep something:
         1. we change it to CelliTem
         2. we fill the keeper arrays
         3. Reload the Table*/
        
        if let i = (self.defaults.array(forKey: "firstPhrase")?.count) {
            
            //1: get data from plist and produce CelliTems
            for index in 0...i-1 {
                let newItemM = CelliTem.init(title: self.defaults.array(forKey: "firstPhrase")![index] as! String, description: self.defaults.array(forKey: "secondPhrase")![index] as! String, cellState: (self.defaults.array(forKey: "stateKey")![index] as! Bool))
                self.storageArray.append(newItemM)
            }
            
            //2: set Keeper arrays:
            self.titleKeeper        = self.defaults.array(forKey: "firstPhrase")    as! [String]
            self.descriptionKeepr   = self.defaults.array(forKey: "secondPhrase")   as! [String]
            self.stateKeeper        = self.defaults.array(forKey: "stateKey")       as! [Bool]
            
            //3: Reload the tableView
            // this will call on viewDidLoad (first page)
        }
    }
    
    
    
    //
    func addToCellManagerStorage(firstString: String = "firstEmpty", secondString: String = "secondEmpty", stateOfCheckmark : Bool = false) {
        
        let newItem = CelliTem.init(title: firstString, description: secondString)
        storageArray.append(newItem)
        
        titleKeeper.append(firstString)
        descriptionKeepr.append(secondString)
        stateKeeper.append(stateOfCheckmark)
        
        defaults.set(titleKeeper,       forKey: "firstPhrase")
        defaults.set(descriptionKeepr,  forKey: "secondPhrase")
        defaults.set(stateKeeper,       forKey: "stateKey")
    }
    
    
    
    //Explnation: this func by using the pointer and storageArray will produce a modified cell
    func cellProducer(theCell : TableViewCell, pointer : Int) -> TableViewCell {
        
        theCell.labelFirst.text     = self.storageArray[pointer].titleM
        theCell.labelSecond.text    = self.storageArray[pointer].descriptionM
        theCell.accessoryType       = self.storageArray[pointer].cellStateM ? .checkmark : .none
        
        return theCell
    }
    
    
    func stateChanger(pointer : Int) {
        
        self.storageArray[pointer].cellStateM   = !self.storageArray[pointer].cellStateM
        self.stateKeeper[pointer]               = !self.stateKeeper[pointer]
        self.defaults.set(self.stateKeeper, forKey: "stateKey")
    }
}
