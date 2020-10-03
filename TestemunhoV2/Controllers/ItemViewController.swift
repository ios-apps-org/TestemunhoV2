//
//  ViewController.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import RealmSwift
import UIKit

class ItemViewController: SwipeTableViewController {

    // MARK: - Properties
    
    var items: Results<Item>?
    let realm = try! Realm()
    
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


    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - ItemViewController Functions
    
    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        // Note: call data source functions again
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        // super.updateModel(at: indexPath)
        
        if let item = self.items?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            } catch {
                print("Error deleting item, \(error.localizedDescription)")
            }
        }
    }
    

    // MARK: - IBActions
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
            if let title = alert.textFields?.first?.text {
                
                if let currentCategory = self?.selectedCategory {
                    do {
                        try self?.realm.write {
                            let newItem = Item()
                            newItem.title = title
                            newItem.createdDate = Date()
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print("Error saving item: \(error.localizedDescription)")
                    }
                }
                
                self?.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
        }
        
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }
}
