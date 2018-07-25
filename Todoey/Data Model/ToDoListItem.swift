//
//  ToDoListItem.swift
//  Todoey
//
//  Created by Paco Sebastián Rebollar on 22/7/18.
//  Copyright © 2018 Paco Sebastián Rebollar. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoListItem: Object {
    @objc dynamic var item : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
