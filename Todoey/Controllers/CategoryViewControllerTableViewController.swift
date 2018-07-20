//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Paco Sebastián Rebollar on 19/7/18.
//  Copyright © 2018 Paco Sebastián Rebollar. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewControllerTableViewController: UITableViewController {
    
    var userCategories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var userEnteredText = UITextField()
        
        let alert = UIAlertController(title: "New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Category(context: self.context)
            
            newItem.name = userEnteredText.text
            self.userCategories.append(newItem)
            
            self.saveData()
            
        }
        
        alert.addAction(action)
        alert.addTextField { (textField) in
            textField.placeholder = "New Category"
            userEnteredText = textField
        }
        present(alert, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }

    //MARK: ~ TableView Datasource Methods
    func loadItems() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            userCategories = try context.fetch(request)
        } catch {
            print("Fetch issue")
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = userCategories[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItemList", sender: self)
    }
    
    func saveData () {
        do {
            try context.save()
        } catch {
            print("Save data error")
        }
        tableView.reloadData()
    }
    //MARK: ~ Data Manipulation Methods
    
    
    //MARK: ~ Add New Categories
    
    
    //MARK: ~ TableView Delegate Methods
    
}
