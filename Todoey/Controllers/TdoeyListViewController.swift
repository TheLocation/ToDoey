//
//  ViewController.swift
//  Todoey
//
//  Created by Matteo Postorino on 22/07/2019.
//  Copyright © 2019 Matteo Postorino. All rights reserved.
//

import UIKit

class TdoeyListViewController: UITableViewController {

    //Now array is usable initiallizig it as va
    var itemArray = [Item]()
    
    //Initializing file manager to store data into app Sandbox
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") //It is an array so I take first element

    //Initializing Default User Settings to Store Data into our app dominio
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("data + \(dataFilePath!)")
        
        /*
        let newItem_1 = Item()
        newItem_1.title = "Sephiroth"
        itemArray.append(newItem_1)
        
        let newItem_2 = Item()
        newItem_2.title = "Cloud"
        itemArray.append(newItem_2)
        
        let newItem_3 = Item()
        newItem_3.title = "Squall"
        itemArray.append(newItem_3)
        
        let newItem_4 = Item()
        newItem_4.title = "Rinoa"
        itemArray.append(newItem_4)
        */
     
        //showing saved array into default stored data. Cast it as an array of strings.
        
        loadData()
        
        //Adding an if statement to check if data exists
        //if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            //itemArray = items
        
    }
    
    //Table view DataSource Methods
    //Telling Xcode to create N cells depending on array count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    //Intializing cell inside a TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //selecting localTableview referring to local argument, not global.
        
        //Checkmark is a property of the cell, so if that cell is dequed, checkmark will be kept in the same cell but value will be different -> It is necessary to associate checkmark with the cell+value itself.
        
        //We Use a model
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        item.done == true ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        
        /*
        if item.done == true {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        */
        return cell //UItableViewCell has to be returned
    }
    
    //Setting table view func to tell delegate row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        //Setting cell property so as user can change it depending on actual status (true ->false; false->true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveData()
        
        //FOLLOWING CODE DOES THE SAME THING
        /*
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }
        else {
            itemArray[indexPath.row].done = false
        }
        */
        
        //tableView.reloadData()
        
        //Cell ogject for managing its features
        //let myCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        //if myCell.accessoryType == .checkmark
        //{
        //    tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //}
        //else if myCell.accessoryType == .none
        //{
        //    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //}
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
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveData()
            
            //Saving added element to default settings
            //You can retrieve all elements saved by using set key command
            //We need ID of Sandbox and Simulator where data is stored -> AppDelegate.swift
             
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            //Initialazing encoder to read stored data on plist file.
            let encoder = PropertyListEncoder()
            
            do
            {
                let data = try encoder.encode(self.itemArray)
                try data.write(to:self.dataFilePath!)
            }
            catch
            {
                print("Error encoding data \(error)")
            }
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
    
    func saveData(){
        let encoder = PropertyListEncoder()
        
        do
        {
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        }
        catch
        {
            print("Error encoding data \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadData(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do
            {
            itemArray = try decoder.decode([Item].self, from: data)
            }
            catch
            {
                print("Error decoding Item Array, \(error)")
            }
           
        }
    }
    
}

