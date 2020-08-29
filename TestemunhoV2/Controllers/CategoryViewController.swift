//
//  CategoryViewController.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/28/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

class CategoryViewController: UITableViewController {

    // MARK: - variables
    
    var categories = [Category]()
    var dataController: DataController!
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    
    // MARK: - internal methods
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categories = try dataController.viewContext.fetch(request)
        } catch {
            print("Error loading categories, \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    func saveCategories() {
        do {
            try dataController.viewContext.save()
        } catch {
            print("Error saving category, \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let category = Category(context: self.dataController.viewContext)
            category.name = textField.text!
            self.categories.append(category)
            
            self.saveCategories()
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            field.placeholder = "Create new category"
            textField = field
        }
        
        present(alert, animated: true, completion: nil)
    }
}
