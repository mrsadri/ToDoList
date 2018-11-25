//
//  AddNewTaskView.swift
//  ToDoList
//
//  Created by MSadri on 11/25/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
import UIKit
var currentGroup : Int = 0

class AddNewTaskView : UIView {
    
    /*
     1. TaskTitleTextField
     2. TaskDescriptionTextField
     3. SubmitButton
     */
    //1
    let taskTitleTextField : UITextField = {
        let thisField = UITextField()
        thisField.translatesAutoresizingMaskIntoConstraints = false
        thisField.layer.cornerRadius = 15
        thisField.backgroundColor = .white
        thisField.placeholder = "Title"
        thisField.textAlignment = .center
        return thisField
    }()
    
    //2
    let taskDescriptionTextField : UITextField = {
        let thisField = UITextField()
        thisField.translatesAutoresizingMaskIntoConstraints = false
        thisField.layer.cornerRadius = 15
        thisField.backgroundColor = .white
        thisField.placeholder = "Description"
        thisField.textAlignment = .left
        return thisField
    }()
    
    //3
    let submitButton : UIButton = {
        let thisButton = UIButton()
        thisButton.translatesAutoresizingMaskIntoConstraints = false
        thisButton.backgroundColor = .blue
        thisButton.layer.cornerRadius = 15
        thisButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        
        return thisButton
    }()
    
    @objc func submitAction(){
        print("ready to submit to the data base")
        /*
         Q: Which Group?
         A: PageController From SwipController
         How? by using a delegate or Global varray
         */
        if taskTitleTextField.text! != "" {
            let groupID = wholeDate[currentGroup].groupData.groupID
            print("Id for this Group: \(groupID)")
            TalkToServer.sharedObject.createTask(group_id: groupID, taskName: taskTitleTextField.text!, taskDescription: taskDescriptionTextField.text!)
            taskTitleTextField.text       = ""
            taskDescriptionTextField.text = ""
            self.isHidden = true
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor.purple
        setUpLayOut()
        
    }
    
    func setUpLayOut() {
        self.addSubview(taskTitleTextField)
        taskTitleTextField.topAnchor    .constraint(equalTo: self.topAnchor    , constant: 10).isActive = true
        taskTitleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        taskTitleTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor)              .isActive = true
        taskTitleTextField.heightAnchor .constraint(equalToConstant: 35)                      .isActive = true
        
        self.addSubview(taskDescriptionTextField)
        taskDescriptionTextField.topAnchor.constraint(equalTo: taskTitleTextField.bottomAnchor, constant: 5).isActive = true
        taskDescriptionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        taskDescriptionTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        taskDescriptionTextField.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: taskDescriptionTextField.bottomAnchor, constant: 10).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
