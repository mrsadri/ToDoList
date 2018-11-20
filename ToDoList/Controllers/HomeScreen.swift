//
//  HomeScreen.swift
//  ToDoList
//
//  Created by MSadri on 11/21/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import Foundation
import UIKit



class HomeScreen : UIViewController, toAccessHomeFunctions {
    
    
    //static let sharedObject = HomeScreen()
    
    func loadTheApplication(){
        print(wholeDate)
        print("try to load the application")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipingController = SwipController(collectionViewLayout: layout)
        //swipingController.view.backgroundColor = .black
        self.present(swipingController, animated: true) {
            //nothing
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        
        TalkToServer.sharedObject.delegetionForThisClass = self
        
        TalkToServer.sharedObject.getGroup()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 60){
        }
        
    }
}
