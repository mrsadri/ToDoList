//
//  TableCell.swift
//  ToDoList
//
//  Created by MSadri on 11/22/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
import UIKit

class TableCell : UITableViewCell {
    
    let cellTextLabel : UILabel = {
        let thisView = UILabel()
        thisView.translatesAutoresizingMaskIntoConstraints = false
        thisView.backgroundColor = .orange
        return thisView
    }()
    
    
    
    var i = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        i += 1
        print("I am cell no.\(i)")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.addSubview(cellTextLabel)
        cellTextLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        cellTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        cellTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
       //
    }
    
}
