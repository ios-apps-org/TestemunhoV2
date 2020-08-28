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
    
    // Note: can use several smaller plists for faster loading time
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Todo.plist")
    var itemArray = [Item]()
            

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)

        loadItems()
    }
    
    
    // MARK: - internal methods
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error.localizedDescription)")
        }
        
        tableView.reloadData()
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
            
            self.saveItems()
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
