//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Paco Sebastián Rebollar on 19/7/18.
//  Copyright © 2018 Paco Sebastián Rebollar. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewControllerTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var userCategories: Results<Category>?
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var userEnteredText = UITextField()
        
        let alert = UIAlertController(title: "New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Category()
            
            newItem.name = userEnteredText.text!
            
            self.save(category: newItem)
            
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
        
        userCategories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCategories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = userCategories?[indexPath.row]
        
        cell.textLabel?.text = item?.name ?? "No cattegories added"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItemView", sender: self)
    }
    
    func save (category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Save data error")
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = userCategories?[indexPath.row]
            print(indexPath.row)
        } else {
            print("no va")
        }
    
    }
    //MARK: ~ Data Manipulation Methods
    
    
    //MARK: ~ Add New Categories
    
    
    //MARK: ~ TableView Delegate Methods
    
}
