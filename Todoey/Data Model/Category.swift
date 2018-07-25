//
//  Category.swift
//  Todoey
//
//  Created by Paco Sebastián Rebollar on 22/7/18.
//  Copyright © 2018 Paco Sebastián Rebollar. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    var items = List<ToDoListItem>()
}
