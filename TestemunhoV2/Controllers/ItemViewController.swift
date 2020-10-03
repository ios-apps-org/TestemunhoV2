//
//  ViewController.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import ChameleonFramework
import RealmSwift
import UIKit

class ItemViewController: SwipeTableViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
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
        
        // Note: point when view has been loaded up
        //       but view may not have been inserted into navigation controller
        //       might not be in navigation stack yet
        
    }
    
    // Note: gets called later than viewDidLoad
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Note: point just before view appears on screen
        //       after views been loaded up
        //       after navigation stack has been established
        
        guard let colorHex = selectedCategory?.color else { fatalError() }
        
        title = selectedCategory?.name
        
        updateNavBar(withHexCode: colorHex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateNavBar(withHexCode: "1d9bf6")
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
    
    func updateNavBar(withHexCode colorHexCode: String) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist.")
        }
        
        guard let navBarColor = UIColor(hexString: colorHexCode) else { fatalError() }
        
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
        navBar.backgroundColor = navBarColor
        searchBar.barTintColor = navBarColor
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
