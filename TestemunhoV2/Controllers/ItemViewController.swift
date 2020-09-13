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
    var fetchedResultsController: NSFetchedResultsController<Item>!
    var onContentUpdated: (() -> Void)? = nil
    
    
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
        
        loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadItems()
    }
    
    
    // MARK: - internal methods
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
      
        let sortDescriptor = NSSortDescriptor(key: "createdDate", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        let categoryPredicate = NSPredicate(format: "%K MATCHES %@", "category.name", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "\(selectedCategory!)-items")
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            
            tableView.reloadData()
        } catch {
            fatalError("Fetching items could not be performed: \(error.localizedDescription)")
        }
    }
    
    func saveItem(title: String) {
        let item = Item(context: self.dataController.viewContext)
        item.title = title
        item.done = false
        item.category = self.selectedCategory
        
        try? dataController.viewContext.save()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
            if let title = alert.textFields?.first?.text {
                self?.saveItem(title: title)
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
        }
        
        alert.addAction(addAction)
        
        present(alert, animated: true, completion: nil)
    }
}
