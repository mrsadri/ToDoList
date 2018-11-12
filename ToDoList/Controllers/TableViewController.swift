//
//  TableViewController.swift
//  ToDoList
//
//  Created by MSadri on 9/17/18.
//  Copyright © 2018 MSadri. All rights reserved.
//


import Alamofire
import SwiftyJSON
import UIKit

var dataFilePathGlobalVarray : URL? = nil
class TableViewController: UITableViewController {
    
    
    @IBOutlet var tblView: UITableView!
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        // ---
        var newiTem = UITextField()
        var newiTem2 = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //Why I use singletone here?
            CellManager.sharedObject.addNewCell(firstString: newiTem.text!, secondString: newiTem2.text!)
            
            //- -   -   -   -   -   -
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel")
        }
        
        
        alert.addTextField { (alertTexfield) in
            alertTexfield.placeholder = "What is its title?"
            newiTem = alertTexfield
        }
        
        alert.addTextField { (alertTexfield) in
            alertTexfield.placeholder = "What is it?"
            newiTem2 = alertTexfield
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        present(alert, animated: true) {
            //do nothing
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if TalkToServer.sharedObject.tokenKeeper == "" {
            let loginPage = storyboard?.instantiateViewController(withIdentifier: "loginPageId") as! LoginPageVC
            present(loginPage, animated: true, completion: nil)
        } else {
            print("Hello Back \(TalkToServer.sharedObject.userData.firstName)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //----temp

        //----
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        
        print("\nThe path is: \(String(describing: dataFilePath))")
        
        dataFilePathGlobalVarray = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ItemsByEncoder.plist")
        
        PLDBManager.sharedObject.fetchDataFromPListToArray()
        tblView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (CellManager.sharedObject.arrayOfCelliTems).count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IDofCell", for: indexPath) as! TableViewCell
        
        return CellManager.sharedObject.cellProducer(theCell: cell, pointer: indexPath.row)
    }
    
    
    // MARK: - TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        CellManager.sharedObject.stateChanger(pointer: indexPath.row)
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// BuG: empty cell should not be added
// BuG: 
