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
    
    var itemArray = [
        "Find Mike",
        "Buy Eggos",
        "Destroy Demogorgon"
    ]
    
    let defaults = UserDefaults.standard
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = UserDefaults.standard.array(forKey: "TodoList") as? [String] {
            itemArray = items
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Completion handler executes from previous closure~")
            
            self.itemArray.append(textField.text!)
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
