//
//  TableViewController.swift
//  ToDoList
//
//  Created by MSadri on 9/17/18.
//  Copyright © 2018 MSadri. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    @IBOutlet var tblView: UITableView!
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        // ---
        var newiTem = UITextField()
        var newiTem2 = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //Why I use singletone here?
            CellManager.sharedObject.addToCellManagerStorage(firstString: newiTem.text!, secondString: newiTem2.text!)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("didLoad is called")
        
        //Eplanation: !! it is so wierd here, I am equalified two refrences of two static variable the same! then whenever I change one of them the scond one is changed automatically. this may produce many BUGs in the future
        if let appenditem = CellManager.sharedObject.defaults.array(forKey: "firstPhraseArrayinPList") as? [String] {
            CellManager.sharedObject.storageArray["firstPhrase"] = appenditem
            print("append iTem is called")
        }
        if let appenditem2 = CellManager.sharedObject.defaults.array(forKey: "secondPhraseArrayinPList") as? [String] {
            CellManager.sharedObject.storageArray["secondPhrase"] = appenditem2
        }
        
        //self.tblView.dataSource = self
        //self.tblView.delegate = self
        
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
        return CellManager.sharedObject.storageArray["firstPhrase"]!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IDofCell", for: indexPath) as! TableViewCell
        
        return CellManager.sharedObject.cellProducer(theCell: cell, pointer: indexPath.row)
    }
    
    
    // MARK: - TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
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
