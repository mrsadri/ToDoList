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
    var tokenKeeper : String = "" {
        didSet{
            //TODO: write the token to the PList evenif it is ""
            /* if token == "" {present login view} else {
             1: Update self.tableRows
             2: Write tableRows to PList
             3: Reload Table
             }*/
        }
    }
    var userData : (firstName: String, lastName: String) = ("",""){
        didSet{
            //Call VC func to write name again
            //Write name to the PList
        }
    }
    var responseKeeper : (body: JSON, header: JSON) = (body: JSON(""), header: JSON(""))
    var tableRows = [TabaleDataModel]()
    //SingleTone Pattern
    private init() {
        //TODO: Get token from Plist
    }
    static let sharedObject = TalkToServer.init()
    
    func register(firstName: String, lastName: String, password: String, email: String) {
        
        let thisUrl = "http://buzztaab.com:8081/api/register"
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"] // application/json
        let bodyparameters = ["first_name"  : firstName,
                              "last_name"   : lastName,
                              "password"    : password,
                              "email"       : email]
        
        requester(url: thisUrl, headers: headers, bodyparameters: bodyparameters)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            
            if self.responseKeeper.body["message"].stringValue == "ok" {
                print(self.responseKeeper)
                self.tokenKeeper = self.responseKeeper.header["token"].stringValue
                self.userData.firstName = self.responseKeeper.body  ["body"]["first_name"].stringValue
                self.userData.lastName  = self.responseKeeper.body["body"]["last_name" ].stringValue
            } else {
                self.tokenKeeper = ""
            }
        }
        
        //        Alamofire.request( thisUrl, method: .post , parameters: bodyparameters , headers: headers).responseJSON{ response in
        //            if response.result.isSuccess{
        //                let jsonKeeperBody      : JSON = JSON(response.result.value!)
        //                let jsonKeeperHeader    : JSON = JSON(response.response!.allHeaderFields)
        //                print("-+--------")
        //                print(jsonKeeperBody)
        //                print(jsonKeeperHeader)
        //                print("-++-------")
        //                self.tokenKeeper = jsonKeeperHeader["token"].stringValue
        //                //set name and lastName
        //                self.userData.firstName = jsonKeeperBody  ["body"]["first_name"].stringValue
        //                self.userData.lastName  = jsonKeeperHeader["body"]["last_name" ].stringValue
        //            } else {
        //                print("-__-------")
        //                print("Error: \(String(describing: response.result.error))")
        //                self.tokenKeeper = ""
        //            }
        //        }
        
    }
    
    func login(email: String, password: String) {
        
        let thisUrl = "http://buzztaab.com:8081/api/login"
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let bodyparameters = ["email" : email ,
                              "password" : password]
        
        requester(url: thisUrl, headers: headers, bodyparameters: bodyparameters)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            
            if self.responseKeeper.body["message"].stringValue == "ok" {
                print(self.responseKeeper)
                self.tokenKeeper = self.responseKeeper.header["token"].stringValue
                self.userData.firstName = self.responseKeeper.body  ["body"]["first_name"].stringValue
                self.userData.lastName  = self.responseKeeper.body["body"]["last_name" ].stringValue
            } else {
                self.tokenKeeper = ""
            }
        }
        
        //        Alamofire.request( thisUrl, method: .post , parameters: bodyparameters , headers: headers).responseJSON{ response in
        //            if response.result.isSuccess{
        //                let jsonKeeperBody : JSON = JSON(response.result.value!)
        //                let jsonKeeperHeader : JSON = JSON(response.response!.allHeaderFields)
        //                print("-+--------")
        //                print(jsonKeeperBody)
        //                print(jsonKeeperHeader)
        //                print("-++-------")
        //                self.tokenKeeper = jsonKeeperHeader["token"].stringValue
        //                //set name and lastName
        //                self.userData.firstName = jsonKeeperBody  ["body"]["first_name"].stringValue
        //                self.userData.lastName  = jsonKeeperHeader["body"]["last_name" ].stringValue
        //                successFlag = true
        //            } else {
        //                print("-__-------")
        //                print("Error: \(String(describing: response.result.error))")
        //                self.tokenKeeper = ""
        //                successFlag = false
        //            }
        //        }
        
    }
    
    func createGroup(groupName: String) {
        
        let thisUrl = "http://buzztaab.com:8081/api/createGroup/"
        let headers: HTTPHeaders = ["authorization" :/* "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzYwYWM4ZWQtMzhkMy00ZjUzLWE3YjItOWFkOWIzYmRhNjRhIiwiaWF0IjoxNTM5MjUwNTg2fQ.exeb-WXsM06aWMtInkQcaoK7hKJ9NGrUpQUsHkKBdIk"*/  "Bearer +\(tokenKeeper)",
            "Content-Type": "application/x-www-form-urlencoded"]
        let bodyparameters = ["groupName": groupName ]
        
        requester(url: thisUrl, headers: headers, bodyparameters: bodyparameters)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            
            if self.responseKeeper.body["message"].stringValue == "ok" {
                print(self.responseKeeper)
                let newSectionInTable = TabaleDataModel(groupData: (groupName: self.responseKeeper.body["body"]["name"].stringValue, groupID: self.responseKeeper.body["body"]["id"].stringValue), tasksData: [])
                
                self.tableRows.append(newSectionInTable)
            } else {
                //nothing
            }
        }
        
        //        Alamofire.request( thisUrl, method: .post , parameters: bodyparameters , headers: headers).responseJSON{ response in
        //            if response.result.isSuccess{
        //                let jsonKeeperBody : JSON = JSON(response.result.value!)
        //                //let jsonKeeperHeader : JSON = JSON(response.response!.allHeaderFields)
        //                print(jsonKeeperBody)
        //            } else {
        //                print("-__-------")
        //                print("Error: \(String(describing: response.result.error))")
        //                self.tokenKeeper = ""
        //            }
        //        }
        
    }
    
    func deleteGroup(group_id: String)  {
        
        //Since you just know the name of grups not their ID, You may need name of group and call getGroupe and find the ID of the Group then call this func byt the ID! // another way solved this
        
        let thisUrl = "http://buzztaab.com:8081/api/deleteGroup/"
        let headers: HTTPHeaders = ["authorization" :/* "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzYwYWM4ZWQtMzhkMy00ZjUzLWE3YjItOWFkOWIzYmRhNjRhIiwiaWF0IjoxNTM5MjUwNTg2fQ.exeb-WXsM06aWMtInkQcaoK7hKJ9NGrUpQUsHkKBdIk"*/  "Bearer +\(tokenKeeper)",
            "Content-Type": "application/x-www-form-urlencoded"]
        let bodyparameters = ["group_id": group_id ]
        
        requester(url: thisUrl, headers: headers, bodyparameters: bodyparameters)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            // BUG: server always rspond "OK"
            
            if self.responseKeeper.body["message"].stringValue == "ok" {
                print(self.responseKeeper)
                for index in 0...(self.tableRows.count - 1){
                    if self.tableRows[index].groupData.groupID == group_id {
                        self.tableRows.remove(at: index)
                        //TODO: write self.tableRows to Plist and reload table
                    }
                }
            } else {
                //nothing
            }
        }
        
    }
    
    func getGroup(group_id: String = "1") {
        //- BUG: GroupId is not neccesary here, just the token is matter
        
        let thisUrl = "http://buzztaab.com:8081/api/getGroup/"
        let headers: HTTPHeaders = ["authorization" :/* "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzYwYWM4ZWQtMzhkMy00ZjUzLWE3YjItOWFkOWIzYmRhNjRhIiwiaWF0IjoxNTM5MjUwNTg2fQ.exeb-WXsM06aWMtInkQcaoK7hKJ9NGrUpQUsHkKBdIk"*/  "Bearer +\(tokenKeeper)",
            "Content-Type": "application/x-www-form-urlencoded"]
        let bodyparameters = ["group_id": group_id ]
        
        requester(url: thisUrl, headers: headers, bodyparameters: bodyparameters)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            // BUG: server always rspond "OK"
            if self.responseKeeper.body["message"].stringValue == "ok" {
                print(self.responseKeeper)
                //count the JSON parameters in body then write a for here
                for index in 0...self.responseKeeper.body["body"].count-1 {
                    /*BUG: it will faced out of range error, the solution:
                     step 1: empty the array at first (if requst is success)
                     step 2: apend groupData 1by1 to the array
                     step 3: call getTask by groupID to fill taskData in the array
                     step 4 : reload the table*/
                    self.tableRows[index].groupData.groupID   = self.responseKeeper.body["body"][index]["id"  ].stringValue
                    self.tableRows[index].groupData.groupName = self.responseKeeper.body["body"][index]["name"].stringValue
                }
            } else {
                //nothing
            }
        }
        
        
    }
    
    func updateGroup(groupName: String, group_id: String){ //Change Group name
        
        //As same as "DeleteGroup" you just know the name of group not its ID
        let thisUrl = "http://buzztaab.com:8081/api/updateGroup/"
        let headers: HTTPHeaders = ["authorization" :/* "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzYwYWM4ZWQtMzhkMy00ZjUzLWE3YjItOWFkOWIzYmRhNjRhIiwiaWF0IjoxNTM5MjUwNTg2fQ.exeb-WXsM06aWMtInkQcaoK7hKJ9NGrUpQUsHkKBdIk"*/  "Bearer +\(tokenKeeper)",
            "Content-Type": "application/x-www-form-urlencoded"]
        let bodyparameters = ["group_id": group_id ]
        
        requester(url: thisUrl, headers: headers, bodyparameters: bodyparameters)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            // BUG: server always rspond "OK"
            if self.responseKeeper.body["message"].stringValue == "ok" {
                print(self.responseKeeper)
                //count the JSON parameters in body then write a for here
                for index in 0...(self.tableRows.count - 1){
                    if self.tableRows[index].groupData.groupID == group_id {
                        self.tableRows[index].groupData.groupName = groupName
                        //TODO: write self.tableRows to Plist and reload table
                    }
                }
                
                
            } else {
                //nothing
            }
        }
        
        
        
        
        
    }
    
    func createTask(group_id: String , taskName: String, taskDescription: String, executionTime : String = "fd"){
        //BUG: API, when create a task in the none exist group server does not respond in a proper way.
        
        let thisUrl = "http://buzztaab.com:8081/api/createTask/"
        let headers: HTTPHeaders = ["authorization" :/* "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzYwYWM4ZWQtMzhkMy00ZjUzLWE3YjItOWFkOWIzYmRhNjRhIiwiaWF0IjoxNTM5MjUwNTg2fQ.exeb-WXsM06aWMtInkQcaoK7hKJ9NGrUpQUsHkKBdIk"*/  "Bearer +\(tokenKeeper)",
            "Content-Type": "application/x-www-form-urlencoded"]
        let bodyparameters = ["group_id": group_id ,
                              "taskName":taskName,
                              "taskDescription":taskDescription,
                              "executionTime" : "fd" ]
        
        requester(url: thisUrl, headers: headers, bodyparameters: bodyparameters)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            // BUG: server always rspond "OK"
            if self.responseKeeper.body["message"].stringValue == "ok" {
                print(self.responseKeeper)
                //count the JSON parameters in body then write a for here
                for index in 0...(self.tableRows.count - 1){
                    if self.tableRows[index].groupData.groupID == group_id {
                        
                        let newTask = (taskName: taskName, taskID: self.responseKeeper.body["body"]["id"].stringValue, taskDescription: taskDescription, doneStatus: false)
                        
                        self.tableRows[index].tasksData.append(newTask)
                        //TODO: write self.tableRows to Plist and reload table
                    }
                }
                
                
            } else {
                //nothing
            }
        }
    }
    
    func deleteTask(task_id: String) {
        let thisUrl = "http://buzztaab.com:8081/api/deleteTask/"
        let headers: HTTPHeaders = ["authorization" :/* "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzYwYWM4ZWQtMzhkMy00ZjUzLWE3YjItOWFkOWIzYmRhNjRhIiwiaWF0IjoxNTM5MjUwNTg2fQ.exeb-WXsM06aWMtInkQcaoK7hKJ9NGrUpQUsHkKBdIk"*/  "Bearer +\(tokenKeeper)",
            "Content-Type": "application/x-www-form-urlencoded"]
        let bodyparameters = ["task_id": task_id ]
        
        requester(url: thisUrl, headers: headers, bodyparameters: bodyparameters)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            // BUG: server always rspond "OK"
            if self.responseKeeper.body["message"].stringValue == "ok" {
                print(self.responseKeeper)
                //count the JSON parameters in body then write a for here
                for gIndex in 0...(self.tableRows.count - 1){
                    if self.tableRows[gIndex].tasksData.count != 0 {
                        for tIndex in 0...(self.tableRows[gIndex].tasksData.count - 1) {
                            if self.tableRows[gIndex].tasksData[tIndex].taskID == task_id {
                                self.tableRows[gIndex].tasksData.remove(at: tIndex)
                            }
                        }
                    }
                }
                //TODO: write self.tableRows to Plist and reload table
                
            } else {
                //nothing
            }
        }
        
    }
    
    func getTask(group_id : String) {
        let thisUrl = "http://buzztaab.com:8081/api/getTask/"
        let headers: HTTPHeaders = ["authorization" :/* "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzYwYWM4ZWQtMzhkMy00ZjUzLWE3YjItOWFkOWIzYmRhNjRhIiwiaWF0IjoxNTM5MjUwNTg2fQ.exeb-WXsM06aWMtInkQcaoK7hKJ9NGrUpQUsHkKBdIk"*/  "Bearer +\(tokenKeeper)",
            "Content-Type": "application/x-www-form-urlencoded"]
        let bodyparameters = ["group_id": group_id ]
        
        requester(url: thisUrl, headers: headers, bodyparameters: bodyparameters)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            // BUG: server always rspond "OK"
            if self.responseKeeper.body["message"].stringValue == "ok" {
                print(self.responseKeeper)
                /*TODO:
                 1: Find the section(ie Group) by groupID
                 2: empty the list of tasks (ie TaskData)
                 3: then apend items 1by1 to it*/
                
                //count the JSON parameters in body then write a for here
                if self.responseKeeper.body["body"].count != 0 {
                    for index in 0...self.responseKeeper.body["body"].count-1 {
                        let _ = (taskName:        self.responseKeeper.body["body"][index]["taskName"          ].stringValue,
                                       taskID:          self.responseKeeper.body["body"][index]["id"                ].stringValue,
                                       taskDescription: self.responseKeeper.body["body"][index]["taskDescription"   ].stringValue,
                                       doneStatus: false)
                    }
                }
                //TODO: write self.tableRows to Plist and reload table
                
            } else {
                //nothing
            }
        }
        
    }
    
    func updateTask() {
    }
    
    //this func will fetch all data at first step from server
    func fetchAll() { //getGroup is doing the same action
        /*
         1: call getGroup
         2: by every groupID call get task
         3: the self.tableRows will fill automaticaly
         4: write data to the PList
         5: reload the Table
         */
    }
    
    func requester(url: String, headers: HTTPHeaders, bodyparameters: [String : String] ) {
        
        
        Alamofire.request( url, method: .post , parameters: bodyparameters , headers: headers).responseJSON{ response in
            if response.result.isSuccess{
                let jsonKeeperBody : JSON = JSON(response.result.value!)
                let jsonKeeperHeader : JSON = JSON(response.response!.allHeaderFields)
                self.responseKeeper = (body: jsonKeeperBody, header: jsonKeeperHeader)
            } else {
                print("Error: \(String(describing: response.result.error))")
                let defaultBodyJSON : JSON = JSON( ["message": "Server Out Of Reach"])
                self.responseKeeper = ((body: defaultBodyJSON, header: JSON("")))
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {}
    }
    
}
//- Note: SingleTone pattern is not suitable for this case and I have to use delegation pattern
//- TODO: Define a requester func to call alamofire with header, body, and url and return bodyJSON and HeaderJSON :Done
//- TODO: if token == "" ban all this funcs: getGroup, createGroup, ...
//- TODO: if JSON message == "ok" { successFlag = true } :Done in other way
//- TODO: Encapsulate this Class (ie these methodes: getGroup, createGroup, ...) with reloadTable Data, then move requester method to TalkToServer Class
//- TODO: reload tabelData in success clouser in all methodes

