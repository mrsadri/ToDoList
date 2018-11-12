//
//  PLDBManager.swift
//  ToDoList
//
//  Created by MSadri on 10/15/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
class PLDBManager {
    
    static let sharedObject = PLDBManager()
    private init() {}
    
    
    let propertyList : PropertyListEncoder = PropertyListEncoder()

    
    
    func fetchDataFromPListToArray(){

        if let fetchedData = try? Data(contentsOf: dataFilePathGlobalVarray!) {
            let decoder = PropertyListDecoder()
            do{
                CellManager.sharedObject.arrayOfCelliTems = try decoder.decode([CelliTem].self, from: fetchedData)
            } catch {
                print(error)
            }
        }
    }
    
    
    func updatePlist(from array: [CelliTem]) {
        
        do {
            let newData = try propertyList.encode(array)
            try newData.write(to: dataFilePathGlobalVarray!)
        } catch {
            print("Error: \(error)")
        }
    }
    
    
    
    
    
}
