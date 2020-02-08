//
//  Category.swift
//  Todoey
//
//  Created by Matteo Postorino on 11/01/2020.
//  Copyright © 2020 Matteo Postorino. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var title = " "
    //initializing empty List for Items inside category
    let items = List<Item>() //Syntax for initializing and empty list of "Item" type.
}
