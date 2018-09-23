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
    
    //
    func addToCellManagerStorage(firstString: String = "firstEmpty", secondString: String = "secondEmpty", stateOfCheckmark : Bool = false) {
        let newItem = CelliTem.init(title: firstString, description: secondString)
        storageArray.append(newItem)
        
        if let b = defaults.array(forKey: "firstPhrase") {
            titleKeeper = b as! [String]
            descriptionKeepr = defaults.array(forKey: "secondPhrase") as! [String]
            stateKeeper = defaults.array(forKey: "stateKey") as! [Bool]
        }
        
        titleKeeper.append(firstString)
        descriptionKeepr.append(secondString)
        stateKeeper.append(stateOfCheckmark)
        
        defaults.set(titleKeeper, forKey: "firstPhrase")
        defaults.set(descriptionKeepr, forKey: "secondPhrase")
        defaults.set(stateKeeper, forKey: "stateKey")
        
    }
    
    
    
    //Explnation: this func by using the pointer and storageArray will produce a modified cell
    func cellProducer(theCell : TableViewCell, pointer : Int) -> TableViewCell {
        
        theCell.labelFirst.text = self.storageArray[pointer].titleM
        theCell.labelSecond.text = self.storageArray[pointer].descriptionM
        
        if self.storageArray[pointer].cellStateM {
            theCell.accessoryType = .checkmark
        } else {
            theCell.accessoryType = .none
        }
        
        return theCell
    }
}
