//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Paco Sebastián Rebollar on 25/7/18.
//  Copyright © 2018 Paco Sebastián Rebollar. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if tableView.tag == 2 {
            if orientation == .right {
                
                let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                    self.deleteModel(at: indexPath)
                }
                deleteAction.image = UIImage(named: "delete-icon")
                return [deleteAction]
                
                
            } else {
                let markAction = SwipeAction(style: .default, title: "Done") { action, indexPath in
                    self.checkModel(at: indexPath)
                }
                markAction.image = UIImage(named: "read-icon")
                markAction.backgroundColor = #colorLiteral(red: 0, green: 0.4577052593, blue: 1, alpha: 1)
                return [markAction]
            }
        } else {
            guard orientation == .right else { return nil }
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                self.deleteModel(at: indexPath)
            }
            deleteAction.image = UIImage(named: "delete-icon")
            return [deleteAction]
        }
    
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        if orientation == .right {
            options.expansionStyle = .destructive
            options.transitionStyle = .border
        } else {
            options.expansionStyle = .selection
            options.transitionStyle = .border
        }
        
        return options
    }

    func deleteModel(at indexPath: IndexPath) {
        
    }
    func checkModel(at indexPath: IndexPath) {
        
    }
    
  
}
