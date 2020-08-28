//
//  ViewController.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {

    // MARK: - variables
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var newItem = Item()
        newItem.title = "Find Mike"
        var newItem2 = Item()
        newItem2.title = "Buy Eggos"
        var newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        
        itemArray.append(newItem)
        itemArray.append(newItem2)
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoList") as? [Item] {
            itemArray = items
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Completion handler executes from previous closure~")
            
            // Note: attempting to save custom object to user defaults
            // Indication to consider another persistence option?
            var item = Item()
            item.title = textField.text!
            self.itemArray.append(item)
            // Note: need to load
            self.defaults.set(self.itemArray, forKey: "TodoList")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            // Note: alertTextField is created as local variable inside closure
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            // Note: closure only gets executed once text field has been added to alert!
            print("Closure triggered but not executed~~")
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
