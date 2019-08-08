//
//  ViewController.swift
//  Todoey
//
//  Created by Matteo Postorino on 22/07/2019.
//  Copyright © 2019 Matteo Postorino. All rights reserved.
//

import UIKit

class TdoeyListViewController: UITableViewController {

    //Now array is usable initiallizig it as var
    var itemArray = ["Sephiroth", "Cloud", "Squall", "Rinoa"]
    
    //Initializing Default User Settings to Store Data into our app dominio
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //showing saved array into default stored data. Cast it as an array of strings.
        
        //Adding an if statement to check if data exists
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = items
        }
    }
    
    //Table view DataSource Methods
    //Telling Xcode to create N cells depending on array count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //Intializing cell inside a TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //selecting localTableview referring to local argument, not global.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell //UItableViewCell has to be returned
    }
    
    //Setting table view func to tell delegate row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //Cell ogject for managing its features
        let myCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        if myCell.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else if myCell.accessoryType == .none
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        //Deselecting row (background colour grey) when pushed
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //Mark - Add IBAction Bar Button Pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //initializing variable to store what's inside alert text field as an information to pass when triggering Add Item
        
        //Alert appearing when pressing + button
        let alert = UIAlertController(title: "Add new Todoey Item", message:" ", preferredStyle: .alert)
        
        //Action appearing when pressing + button
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens when Add Item button is pressed
            
            //Appending new element to array
            self.itemArray.append(textField.text!)
            
            //Saving added element to default settings
            //You can retrieve all elements saved by using set key value
            //We need ID of Sandbox and Simulator where data is stored -> AppDelegate.swift
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
            }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        //Adding action after alert
        alert.addAction(action)
        
        //Presenting alert
        present(alert, animated: true, completion: nil)
        
    }
    
}

