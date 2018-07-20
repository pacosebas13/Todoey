//
//  ViewController.swift
//  Todoey
//
//  Created by Paco Sebastián Rebollar on 15/7/18.
//  Copyright © 2018 Paco Sebastián Rebollar. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var toDoListItems = [ToDoListItem]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let checkText = textField.text {
                
                let newItem = ToDoListItem(context: self.context)
                newItem.item = checkText
                newItem.done = false
                self.toDoListItems.append(newItem)
                self.saveDataMethod()
                self.tableView.reloadData()
                
            } else {
                print("nothing entered")
            }
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
        
        loadItems()
        // Do any additional setup after loading the view, typically from a nib.
//        if let tempArray = defaults.array(forKey: "ToDoListArray") as? [ToDoListItem] {
//            toDoListItems = tempArray
//        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        let item = toDoListItems[indexPath.row]
        
        cell.textLabel?.text = item.item
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        toDoListItems[indexPath.row].done = !toDoListItems[indexPath.row].done
        
//        context.delete(toDoListItems[indexPath.row])
//        toDoListItems.remove(at: indexPath.row)
        
        self.saveDataMethod()
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func saveDataMethod() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()) {
        
        do {
            toDoListItems = try context.fetch(request)
        } catch {
            print("Error fetching")
        }
        tableView.reloadData()
    }
    
}

//MARK: ~ Search bar methods
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()
        
        request.predicate = NSPredicate(format: "item CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "item", ascending: true)]

        loadItems(with: request)

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
