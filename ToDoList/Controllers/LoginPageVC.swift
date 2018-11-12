//
//  LoginPageVC.swift
//  ToDoList
//
//  Created by MSadri on 11/13/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
import UIKit

class LoginPageVC : UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passWordField: UITextField!
    @IBAction func LogInButton(_ sender: UIButton) {
        let flag : Bool = TalkToServer.sharedObject.login(email: userNameField.text!, password: passWordField.text!)
        print("Flag is \(flag)")
        if flag {
            print("\(TalkToServer.sharedObject.userData.firstName) is log in " )
        }
        self.dismiss(animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
