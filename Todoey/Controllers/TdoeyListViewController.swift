//
//  ViewController.swift
//  Todoey
//
//  Created by Matteo Postorino on 22/07/2019.
//  Copyright © 2019 Matteo Postorino. All rights reserved.
//

//CONCEPTS TO BE HIGHLIGHTED
//-> didSet
//-> extensions
//-> creating and destroying data using context and save to persistent container
//-> Singleton

//DO YOUR OWN APP


import UIKit
//import CoreData
import RealmSwift

class TdoeyListViewController: UITableViewController {

    //creating Realm Instance
    let realm = try! Realm() 
    //Now array is usable initiallizig it as var
    var todoItems: Results<Item>?
    
    var selectedCategory : Category? {
        //didSet: in did set brackets things happen when slectedCategory has a value. We call load Items when we are certain we got a selectedCategory value.
        
        didSet{
            loadData()
        }
    }
    
    //adding singleton to refer to context in AppDelegate class
    //In SQLite DB, context defined variable is a "temporary area" where data is temporary stored.
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext - Core Data
    
    //Initializing file manager to store data into app Sandbox
    //---DEPRECATED---//
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") //It is an array so I take first element

    //Initializing Default User Settings to Store Data into our app dominio
    //---DEPRECATED---//
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Printing file path to see where DB data is located
        //print("file + \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
        
        //showing saved array into default stored data. Cast it as an array of strings.
        
        //loadData() //It has a default value (see definition)
        
        //Adding an if statement to check if data exists
        //if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            //itemArray = items
        
    }
    
    //MARK - Table view DataSource Methods
    
    //Telling Xcode to create N cells depending on array count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    
    //Intializing cell inside a TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //selecting localTableview referring to local argument, not global.
        
        //We Use a model
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]{
            
            cell.textLabel?.text = item.title
    
            item.done == true ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        } else {
            cell.textLabel?.text = "No Items Added Yet"
        }
        
     
    
        return cell //UItableViewCell has to be returned
    }
    
    //MARK - TableView Delegate Methods
    
    //Setting table view func to tell delegate row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        //Setting cell property so as user can change it depending on actual status (true ->false; false->true)
        
        //Also possibile to set value using SetValue
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
        //In order to remove a line by selecting it, it's needed firstly to remove object from context (temporary store) so as to tell code the index to be removed, then removing it from table using "remove". We comment out this 2 lines at first.
        /*
        context.delete(itemArray[indexPath.rows])
        itemArray.remove(at: indexPath.row)
        */
        
        //todoItems[indexPath.row].done = !todoItems[indexPath.row].done
    
        
        
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
        
        //Cell object for managing its features
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
        
        //UPdating realm data selecting a row
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write{
                    item.done = !item.done
                    //Command to delete a line
                    //realm.delete(item)
                }
            }
            catch{
                print("\(error) in saving towns!")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //Mark - Add IBAction Bar Button Pressed
    @IBAction func addButtonPressed(_ sender: Any) {
        
        //initializing variable to store what's inside alert text field as an information to pass when triggering Add Item
        
        //Alert appearing when pressing + button
        let alert = UIAlertController(title: "Add new Todoey Item", message:" ", preferredStyle: .alert)
        
        var textField = UITextField()
        
        //Action appearing when pressing + button
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens when Add Item button is pressed
            
            //Appending new element to array
            //Item is a NSManagedObject and it can be identified as a row of our DB. We save it in temporary area "context")
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.date = Date()
                    //appending newitem to selected category
                    currentCategory.items.append(newItem)
                    }
                  }
                    catch
                    {
                        print("\(error) in uploading cities from category")
                    }
                }
            
       self.tableView.reloadData()
            
            //Defining ITEM ATTRIBUTE
    
            
    //newItem.done = false
            
            //Category I Should pass to entity categoru should be the one selected.
    
            
            //setting item's done property to false to avoid error given by saveData class.
            
    //self.itemArray.append(newItem)
            
            //self.saveData()
            
            //Saving added element to default settings
            //-----DEPRECATED-----//
            //You can retrieve all elements saved by using set key command
            //We need ID of Sandbox and Simulator where data is stored -> AppDelegate.swift
            
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            //Initialazing encoder to read stored data on plist file.
            
        }
        
        //AddingTextField to Alert Button (better create a class)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        //Adding action after alert
        alert.addAction(action)
        
        //Presenting alert
        self.present(alert, animated: true, completion: nil)

    }
    
    //MARK: Model Manipulation Methods
    
    
    
//    func saveData(){
//        do
//        {
//            //Saving context permanently
//            try context.save()
//        }
//        catch
//        {
//          print("error saving message, \(error)")
//        }
//        self.tableView.reloadData()
//    }
    
    
    //With: external parameter.
    //Item.fetchRequest() = default value.
    
    //setting predicate to nil so

//MARK - LOAD DATA DEPENDING FROM CHOSEN CATEGORY
    
func loadData(){
    
    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    //adding predicate to show compiler to head to proper selected category.

    //    let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory!.title!)
    //
    ////Adding compoundPredicate to pass category predicate and predicate that get passed in.
    //
    ////Il predicate is nil, we only pass categorypredicate, otherwise we pass both predicates (searchbar and category): It is tone to manage predicate unwrupping set, as a default, as nil (see function arguments)
    //
    //    if let additionalPredicate = predicate{
    //        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
    //            }else
    //            {
    //                request.predicate = categoryPredicate
    //            }
    //
    //            do{
    //                //Assigning fetch request to itemarray, where I store data
    //                itemArray = try context.fetch(request)
    //            }
    //            catch
    //            {
    //                print("error fetching data from context \(error)")
    //            }
    
            tableView.reloadData()
    }
    
//    func loadData(with request:NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
//
//        //adding predicate to show compiler to head to proper selected category.
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory!.title!)
//
//        //Adding compoundPredicate to pass category predicate and predicate that get passed in.
//
//        //Il predicate is nil, we only pass categorypredicate, otherwise we pass both predicates (searchbar and category): It is tone to manage predicate unwrupping set, as a default, as nil (see function arguments)
//
//        if let additionalPredicate = predicate{
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        }else
//        {
//            request.predicate = categoryPredicate
//        }
//
//        do{
//            //Assigning fetch request to itemarray, where I store data
//            itemArray = try context.fetch(request)
//        }
//        catch
//        {
//            print("error fetching data from context \(error)")
//        }
//
//        tableView.reloadData()
//    }
}

//MARK: - SEARCH BAR METHODS

//Extending funcionalities of ToDoListViewController so as to be able to handle searchbar METHODS.

extension TdoeyListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

//MARK - Search bar Realm
        
//Filterind data in todoitems
    
    todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
        
    tableView.reloadData()
        
//MARK - Search bar Core Data
        
//        //initializing request to be fetched to searchbar
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        //query that specifies qhat I want back: %@ is text to be inserted.
//        //MARK - Predicate DOcs: https://academy.realm.io/posts/nspredicate-cheatsheet/
//        //[cd]: insensitive to case and diacritic
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        //Sort by title and ascending order. We report it in titles and in ascending order.
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        //Fetching request as done in loadData:
//        loadData(with: request, predicate: predicate)
    }

    //creating new method to load original list again. It is a delegate method that triggers when text is changed
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Text is changed but it has also gone to zero. When I insert a test and then I clear it for ex
        if searchBar.text?.count == 0 {
            //loading data again
            loadData()

            //telling searchbar to resign
            //DispatchQueue is a Manager that manages threads. We'll tell him to put resigning process of searchbar in another thread (background). As process in bg is executed, data is retreived to main thread so app won't block during execution.


            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
           //background thread
        }
    }
}

