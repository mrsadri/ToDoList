//
//  AddAction.swift
//  ToDoList
//
//  Created by MSadri on 9/19/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
class AddAction {
    // a refrence to keeper array will be here to access the data
    // a popUp window will shown to get data from user
    //
    static let sharedObject = AddAction() // if you want to set property for this Class you have to add it to these oranteses.
    
    private init() {
        print("I am created")
    }
    
    func addIt(stringParameter : String) {
        TableViewController.itemArray.append(stringParameter)
    }
}
