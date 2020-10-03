//
//  CategoryViewController.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/28/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import RealmSwift
import UIKit

class CategoryViewController: UITableViewController {

    // MARK: - Properties
    
    var categories: Results<Category>?
    var onContentUpdated: (() -> Void)? = nil
    let realm = try! Realm()
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCategories()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        
        tableView.reloadData()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] (action) in
            
            if let name = alert.textFields?.first?.text {
                let newCategory = Category()
                newCategory.name = name
    
                self?.save(category: newCategory)
            }
        }
        
        alert.addAction(addAction)
        alert.addTextField { (field) in
            field.placeholder = "Create new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
}
