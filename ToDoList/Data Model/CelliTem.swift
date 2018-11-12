//
//  CelliTem.swift
//  ToDoList
//
//  Created by MSadri on 9/23/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
struct CelliTem : Codable {
    var titleM : String = "Title"
    var descriptionM : String = "Description"
    var cellStateM : Bool = false
    
    init(title: String, description: String, cellState: Bool = false) {
        self.titleM = title
        self.descriptionM = description
        self.cellStateM = cellState
    }

}
