//
//  AddAction.swift
//  ToDoList
//
//  Created by MSadri on 9/19/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
class CellManager {
    
    //let defaults = UserDefaults.standard
    //2 replacing NSCodere instead of UserDefault:
    
    let firstPhraseKey  : String = "firstPhrase"
    let secondPhraseKey : String = "secondPhrase"
    
    var arrayOfCelliTems    = [CelliTem]()
//    var titleKeeper         = [String]()
//    var descriptionKeepr    = [String]()
//    var stateKeeper         = [Bool]()
        
    static let sharedObject = CellManager()
    
    private init() {}
    //---------------------------------------------------------------------
    
    

    
    
    
    //
    func addNewCell(firstString: String = "firstEmpty", secondString: String = "secondEmpty", stateOfCheckmark : Bool = false) {
        
        let newItem = CelliTem.init(title: firstString, description: secondString)
        arrayOfCelliTems.append(newItem)
        
        PLDBManager.sharedObject.updatePlist(from: arrayOfCelliTems)
        
//        titleKeeper.append(firstString)
//        descriptionKeepr.append(secondString)
//        stateKeeper.append(stateOfCheckmark)
        
        
        //write keepers array into defaults
//        defaults.set(titleKeeper     ,forKey: "firstPhrase" )
//        defaults.set(descriptionKeepr,forKey: "secondPhrase")
//        defaults.set(stateKeeper     ,forKey: "stateKey"    )
    }
    
    
    
    //Explnation: this func by using the pointer and storageArray will produce a modified cell
    func cellProducer(theCell : TableViewCell, pointer : Int) -> TableViewCell {
        
        theCell.labelFirst.text  = self.arrayOfCelliTems[pointer].titleM
        theCell.labelSecond.text = self.arrayOfCelliTems[pointer].descriptionM
        theCell.accessoryType    = self.arrayOfCelliTems[pointer].cellStateM ? .checkmark : .none
        
        return theCell
    }
    
    
    func stateChanger(pointer : Int) {
        
        self.arrayOfCelliTems[pointer].cellStateM   = !self.arrayOfCelliTems[pointer].cellStateM
        PLDBManager.sharedObject.updatePlist(from: arrayOfCelliTems)
       // self.stateKeeper[pointer] = !self.stateKeeper[pointer]
       // self.defaults.set(self.stateKeeper, forKey: "stateKey")
    }
    
    func deleteCell(pointer: Int){
        
    }

}
