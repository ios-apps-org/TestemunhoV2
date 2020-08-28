//
//  ViewController.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

class CategoryViewController: UITableViewController {

    // MARK: - variables
    
    // Note: can use several smaller plists for faster loading time
    var dataController: DataController!
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    var itemArray = [Item]()
            

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)

        loadItems()
    }
    
    
    // MARK: - internal methods
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try dataController.viewContext.fetch(request)
        } catch {
            print("Error fetching data from context, \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    func saveItems() {
        do {
            try dataController.viewContext.save()
        } catch {
            print("Error saving context, \(error.localizedDescription)")
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
            let item = Item(context: self.dataController.viewContext)
            item.title = textField.text!
            item.done = false
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
