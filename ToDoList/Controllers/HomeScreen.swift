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
    
    let timerLabelForLoading : UILabel = {
        let thisLabel = UILabel()
        thisLabel.backgroundColor = .white
        thisLabel.translatesAutoresizingMaskIntoConstraints = false
        return thisLabel
    }()
    
    func loadTheApplication(){
        print(wholeDate)
        print("try to load the application")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let swipingController = SwipController(collectionViewLayout: layout)
        //swipingController.view.backgroundColor = .black
        self.present(swipingController, animated: true) {
            //nothing
        }

    }
    
    var timer : Timer?
    func setTimerFirstValue(input: String){
        timerLabelForLoading.text = String(input)
        self.timer = Timer.scheduledTimer(timeInterval:  1, target: self, selector: #selector(self.startLoading), userInfo: nil, repeats: true)
    }
    
    @objc func startLoading() {
        timerLabelForLoading.text = String(Int(timerLabelForLoading.text!)! - 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
  //      TalkToServer.sharedObject.accessToPageCellFromTalkToserver = PageCell.self as! AccessToPageCell
        self.view.addSubview(timerLabelForLoading)
        
        timerLabelForLoading.frame = CGRect(x: 50, y: 50, width: 100 , height: 100)
        
        TalkToServer.sharedObject.delegetionForThisClass = self
        TalkToServer.sharedObject.login(email: "masih@sadri.com", password: "123qwe")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            TalkToServer.sharedObject.getGroup()
        }
        
    }
}
