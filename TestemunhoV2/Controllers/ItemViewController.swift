//
//  ViewController.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import RealmSwift
import UIKit

class ItemViewController: UITableViewController {

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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: - ItemViewController Functions
    
    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "createdDate", ascending: false)
        tableView.reloadData()
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
        
        present(alert, animated: true, completion: nil)
    }
}
