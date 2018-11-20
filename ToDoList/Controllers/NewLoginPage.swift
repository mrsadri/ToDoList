//
//  NewLoginPage.swift
//  ToDoList
//
//  Created by MSadri on 11/20/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
import UIKit

class NewLoginPage : UIViewController {
    
    let textField : UITextField = {
        let thisTextfield = UITextField()
        thisTextfield.translatesAutoresizingMaskIntoConstraints = false
        thisTextfield.textColor = .red
        thisTextfield.text = "Hello, I am free in this view"
        thisTextfield.backgroundColor = .yellow
        return thisTextfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.dismiss(animated: true, completion: {
                //nothing to do
            })
        }
        
    }
    
    func setupLayout() {
        
        view.addSubview(textField)
        
        //textField.frame = CGRect(x: 50, y: 50, width: 200, height: 60)
        print("view is set up in login page")
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    
    
    
}
