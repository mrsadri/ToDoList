//
//  AddAction.swift
//  ToDoList
//
//  Created by MSadri on 9/19/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
class CellManager {
     static var storage : [ String : [String] ] = ["firstPhrase" : ["first1", "first2", "first3"] , "secondPhrase" : ["second1","second2","second3"]]
    // a refrence to keeper array will be here to access the data
    // a popUp window will shown to get data from user
    //
    static let sharedObject = CellManager() // if you want to set property for this Class you have to add it to these pranteses.
    
    private init() {
        print("I am created")
    }
    
    //
    func addToCellManagerStorage(firstString: String = "firstEmpty", secondString: String = "secondEmpty") {
        CellManager.storage["firstPhrase"]!.append(firstString)
        CellManager.storage["secondPhrase"]!.append(secondString)
    }
    
    //Explnation: this func by using the pointer and storage will produce a modified cell
    func cellProducer(theCell : TableViewCell, pointer : Int) -> TableViewCell {
        theCell.labelFirst.text = CellManager.storage["firstPhrase"]![pointer]
        theCell.labelSecond.text = CellManager.storage["secondPhrase"]![pointer]
        return theCell
    }
}
