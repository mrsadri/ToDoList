//
//  HeaderUI.swift
//  ToDoList
//
//  Created by MSadri on 11/24/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
import UIKit

class HeaderUI : UIView {
    
    
    let profileNameLabel : UILabel = {
        let thisLabel = UILabel()
        thisLabel.translatesAutoresizingMaskIntoConstraints = false
        thisLabel.backgroundColor = .yellow
        
        let nameString: String = "   \(TalkToServer.sharedObject.userData.firstName)  \(TalkToServer.sharedObject.userData.lastName)"

        let attributedText = NSMutableAttributedString(string: nameString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.gray])
//        attributedText.append(NSAttributedString(string: "\t\t" + unrappedData.groupData.groupName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]))
        thisLabel.attributedText = attributedText
        
        return thisLabel
    }()
    
    let logOutButton : UIButton = {
        let thisButton = UIButton()
        thisButton.translatesAutoresizingMaskIntoConstraints = false
        thisButton.backgroundColor = .red
        thisButton.layer.cornerRadius = 10
        thisButton.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        return thisButton
    }()
    
    @objc func logOutAction(){
        TalkToServer.sharedObject.tokenKeeper = ""
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.purple
        
        setUpLayOut()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayOut() {
        self.addSubview(profileNameLabel)
        profileNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        profileNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        //profileNameLabel.frame = CGRect(x: 5, y: 5, width: self.frame.width, height: 50)
        
        self.addSubview(logOutButton)
        logOutButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        logOutButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logOutButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
}

