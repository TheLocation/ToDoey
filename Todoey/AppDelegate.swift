//
//  AppDelegate.swift
//  Todoey
//
//  Created by Matteo Postorino on 22/07/2019.
//  Copyright © 2019 Matteo Postorino. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //MP: First delegate method called when launching application.
        
        //printing ID of Sandbox and Simulator to see where data is stored (SEE lesson 225 at 4:50)
        
        //Once lauched app, search for plist file inside library folder (see path displayed in consolle)
        
        return true
    }
 
    func applicationWillTerminate(_ application: UIApplication) {
      
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    //MP: Lazy variable: memory is occupied only when needed.
    
    lazy var persistentContainer: NSPersistentContainer = {
    
        //Creating a new container, sql databes, where data is stored
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
      
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
            
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

