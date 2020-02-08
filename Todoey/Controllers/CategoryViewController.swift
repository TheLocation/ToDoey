//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Matteo Postorino on 06/11/2019.
//  Copyright © 2019 Matteo Postorino. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {

    //initializing Realm DB (see Realm Documentation)
    let realm = try! Realm()
    
    //1.Initializing Array:
    //var catArray = [Category]() - COredata
    var catArray: Results<Category>?
    
    //2. Initializing context variable: it temporary contins data to be stored into SQL DB.
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext - Coredata
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        loadCategory()
        
        //print("file cat + \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
    }
    
    //MARK - TableView DataSource Methods
    //3. Counting rows in table (numberOfRowsInSection)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //If catArray is not nil then return count, otherwise return 1
        return catArray?.count ?? 1
        // ??Nil coalescing operator.
    }
    
    //4. Initializing cell inside tableView(cellForRowAt)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let catCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        catCell.textLabel?.text = catArray?[indexPath.row].title ?? "No categories added yet"
        
        //catItem.done == true ? (catCell.accessoryType = .checkmark) : (catCell.accessoryType = .none)
        
        return catCell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    //Telling Segue to go to next destination.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TdoeyListViewController
        
    //Which selected cell?
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = catArray?[indexPath.row]
        }
    }
    
     //MARK - TableView Data Manipulation Methods
 
    //MARK - AddButtonPressd Methods
    //5. Adding button pressed method
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add category", message: " ", preferredStyle: .alert)
        
        //adding TextField
        var textField = UITextField()
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            
            //let newItem = Category(context: self.context) - CoreData
            let newItem = Category()
            
            //Defining ITEM ATTRIBUTE
            newItem.title = textField.text!
            
            //newItem.done = false
            
            //Result Datatype is an autoupdating container, thus we do not need to append new items to our result database.
            //self.catArray.append(newItem) - CoreData
            
            self.save(category: newItem)
            
        }
        //Adding action after alert
        alert.addAction(action)
        
        //Presenting alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category){
        do
        {
            try realm.write {
                realm.add(category)
            }
            //try context.save() - Coredata
        } catch {
            print("error saving message, \(error)")
        }
        self.tableView.reloadData()
    }
    
    /* CORE DATA
    func loadCategory(with request:NSFetchRequest<Category> = Category.fetchRequest()){
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            //Assigning fetch request to itemarray, where I store data
            catArray = try context.fetch(request)
        }
        catch
        {
            print("error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
 */
    
    func loadCategory(){
        catArray = realm.objects(Category.self)
        tableView.reloadData()
    }
}
