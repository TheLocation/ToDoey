//
//  ViewController.swift
//  Todoey
//
//  Created by Matteo Postorino on 22/07/2019.
//  Copyright © 2019 Matteo Postorino. All rights reserved.
//

import UIKit

class TdoeyListViewController: UITableViewController {

    let itemArray = ["Sephiroth", "Cloud", "Squall", "Rinoa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Table view DataSource Methods
    //Telling Xcode to create N cells depending on array count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //Asking DataSource to insert cell inside a TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //selecting localTableview referring to local argument, not global.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell //UItableViewCell has to be returned
    }
    
    //Setting table view func to tell delegate row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
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
        
        let alert = UIAlertController(title: "Add new Todoey Item", message:" ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens when Add Item button is pressed
            print("Success")
            }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

