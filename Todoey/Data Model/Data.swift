//
//  Data.swift
//  Todoey
//
//  Created by Matteo Postorino on 30/12/2019.
//  Copyright © 2019 Matteo Postorino. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = " "
    @objc dynamic var age: Int = 0
}
