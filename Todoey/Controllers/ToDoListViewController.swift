//
//  ViewController.swift
//  Todoey
//
//  Created by Paco Sebastián Rebollar on 15/7/18.
//  Copyright © 2018 Paco Sebastián Rebollar. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var toDoList: Results<ToDoListItem>?
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let checkText = textField.text {
                
                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let newItem = ToDoListItem()
                            newItem.item = checkText
                            newItem.dateCreated = Date()
                            newItem.done = false
                            currentCategory.items.append(newItem)
                            self.realm.add(newItem)
                        }
                    } catch {
                        print("error saving data")
                    }
                }
            }
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
//        if let tempArray = defaults.array(forKey: "ToDoListArray") as? [ToDoListItem] {
//            toDoListItems = tempArray
//        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = toDoList?[indexPath.row] {
            cell.textLabel?.text = item.item
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoList?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error updating data")
            }
        } else {
            print("Error updating data")
        }
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func loadItems() {
        
        toDoList =  selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    override func checkModel(at indexPath: IndexPath) {
        if let auxToDoList = self.toDoList?[indexPath.row] {
            do {
                try self.realm.write {
                    auxToDoList.done = !auxToDoList.done
                }
            } catch {
                print("issue with deleting")
            }
        } else {
            print("Issue with items")
        }
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
    }
    
    
    
    override func deleteModel(at indexPath: IndexPath) {
        if let auxCategory = self.toDoList?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(auxCategory)
                }
            } catch {
                print("issue with deleting")
            }
        } else {
            print("Issue with categories")
        }
    }
    
    

    
}

//MARK: ~ Search bar methods
extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        toDoList = toDoList?.filter("item CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            toDoList = toDoList?.filter("item CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
            tableView.reloadData()
        }
    }
}
