//
//  Item.swift
//  Todoey
//
//  Created by Matteo Postorino on 11/01/2020.
//  Copyright © 2020 Matteo Postorino. All rights reserved.
//

import Foundation

import RealmSwift

class Item: Object{
    @objc dynamic var title: String = " "
    @objc dynamic var done: Bool = false
    @objc dynamic var date: Date?
    
    //Backward relationship (Item -> Categoru)
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")//Cat.self - type - Item - name of
}
