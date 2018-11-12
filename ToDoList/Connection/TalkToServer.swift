//
//  TalkToServer.swift
//  ToDoList
//
//  Created by MSadri on 11/12/18.
//  Copyright © 2018 MSadri. All rights reserved.
//
import SwiftyJSON
import Alamofire
import Foundation

class TalkToServer {
    
    var tokenKeeper : String? = ""
    var userData : (firstName: String, lastName: String) = ("","")
    var tableRows = [TabaleDataModel]()
    // it need DidSet or Observer, whenever it is "" the loginn page shows to user
    //SingleTone Pattern
    //Note: SingleTone pattern is not suitable for this case and I have to use delegation pattern
    private init() {
        //TODO: Get token from Plist
    }
    static let sharedObject = TalkToServer.init()
    
    func register(firstName: String, lastName: String, password: String, email: String) -> Bool {
        var token : String = ""
        var successFlag = false
        if (true) {
            //Send Request
            //Parse the ressponse
            token = "SampleTokenFromServer"
            successFlag = true
        } else {
            //who is calling this func by recieving a empty token will show error message to user
            token = ""
        }
        //TODO: save token and uuid to PList
        //self.tokenKeeper = token
        return successFlag
        
    }
    
    
    func login(email: String, password: String) -> Bool {
        
        var successFlag = Bool()
        
        let thisUrl = "http://buzztaab.com:8081/api/login"
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let bodyparameters = ["email" : email ,
                              "password" : password]
        
        Alamofire.request( thisUrl, method: .post , parameters: bodyparameters , headers: headers).responseJSON{ response in
            if response.result.isSuccess{
                let jsonKeeperBody : JSON = JSON(response.result.value!)
                let jsonKeeperHeader : JSON = JSON(response.response!.allHeaderFields)
                print("-+--------")
                print(jsonKeeperBody)
                print(jsonKeeperHeader)
                print("-++-------")
                self.tokenKeeper = jsonKeeperHeader["token"].stringValue
                //set name and lastName
                self.userData.firstName = jsonKeeperBody  ["body"]["first_name"].stringValue
                self.userData.lastName  = jsonKeeperHeader["body"]["last_name" ].stringValue
                successFlag = true
            } else {
                print("-__-------")
                print("Error: \(String(describing: response.result.error))")
                self.tokenKeeper = ""
                successFlag = false
            }
        }
        
        return successFlag
    }
    
    func createGroup(groupName: String) -> Bool {
        //use toenKeeper to call it
        return true
    }
    
    func deleteGroup(group_id: String) -> Bool {
        //Since you just know the name of grups not their ID, You may need name of group and call getGroupe and find the ID of the Group then call this func byt the ID!
        return true
    }
    
    func getGroup(group_id: String = "1") -> Bool{
        //GroupId is not neccesary here, just the token is matter
        return true
    }
    
    func updateGroup(groupName: String, group_id: String) -> Bool{ //Change Group name
        //As same as "DeleteGroup" you just know the name of group not its ID
        return true
    }
    
    func getGroupID(groupName: String) -> String{
        return ""
    }
    
    func createTask() {
    }
    
    func deleteTask() {
    }
    
    func getTask() {
    }
    
    func updateTask() {
    }
    
    //this func will fetch all data at first step from server
    func fetchAll() {
        
    }
    
}
