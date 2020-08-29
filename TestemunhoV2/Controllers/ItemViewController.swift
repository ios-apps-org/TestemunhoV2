//
//  ViewController.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

class ItemViewController: UITableViewController {

    // MARK: - variables
    
    var dataController: DataController!
    var itemArray = [Item]()
    
    
    // MARK: - computed properties
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df
    }()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }


    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - internal methods
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "%K MATCHES %@", "category.name", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            itemArray = try dataController.viewContext.fetch(request)
        } catch {
            print("Error loading todo items, \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    func saveItems() {
        do {
            try dataController.viewContext.save()
        } catch {
            print("Error saving todo item, \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let item = Item(context: self.dataController.viewContext)
            item.title = textField.text!
            
            item.done = false
            item.category = self.selectedCategory
            self.itemArray.append(item)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
