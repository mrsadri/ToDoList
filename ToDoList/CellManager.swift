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

//    static var storage : [ String : [String] ] = ["firstPhrase" : ["first1", "first2", "first3"] , "secondPhrase" : ["second1","second2","second3"]]
     var storageArray : [ String : [String] ] = ["firstPhrase" : [] , "secondPhrase" : []]
    // a refrence to keeper array will be here to access the data
    // a popUp window will shown to get data from user
    //
    static let sharedObject = CellManager() // if you want to set property for this Class you have to add it to these pranteses.
    
    private init() {
        print("I am created")
    }
    
    //
    func addToCellManagerStorage(firstString: String = "firstEmpty", secondString: String = "secondEmpty") {
        self.storageArray["firstPhrase"]!.append(firstString)
        self.storageArray["secondPhrase"]!.append(secondString)
        CellManager.sharedObject.defaults.set(self.storageArray["firstPhrase"]!, forKey: "firstPhraseArrayinPList")
        CellManager.sharedObject.defaults.set(self.storageArray["secondPhrase"]!, forKey: "secondPhraseArrayinPList")
    }
    
    //Explnation: this func by using the pointer and storageArray will produce a modified cell
    func cellProducer(theCell : TableViewCell, pointer : Int) -> TableViewCell {
        theCell.labelFirst.text = self.storageArray["firstPhrase"]![pointer]
        theCell.labelSecond.text = self.storageArray["secondPhrase"]![pointer]
        return theCell
    }
}
