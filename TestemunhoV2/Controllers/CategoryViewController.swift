//
//  CategoryViewController.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/28/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import RealmSwift
import UIKit

class CategoryViewController: SwipeTableViewController {

    // MARK: - Properties
    
    var categories: Results<Category>?
    let realm = try! Realm()
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    
    // MARK: - CategoryViewController Functions
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category: \(error.localizedDescription)")
        }
        
        // Note: calls data source functions again
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        // super.updateModel(at: indexPath)
        
        if let category = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(category)
                }
            } catch {
                print("Error deleting category, \(error.localizedDescription)")
            }
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] (action) in
            
            if let name = alert.textFields?.first?.text {
                let newCategory = Category()
                newCategory.name = name
                newCategory.createdDate = Date()
                self?.save(category: newCategory)
            }
        }
        
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        alert.addTextField { (field) in
            field.placeholder = "Create new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
}
