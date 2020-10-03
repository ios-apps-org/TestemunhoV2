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
    
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<Category>!
    var onContentUpdated: (() -> Void)? = nil
    
    
    // MARK: - Lifecycle methods
    
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
        
        fetchedResultsController = nil
    }
    
    
    // MARK: - internal methods
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        let sortDescriptor = NSSortDescriptor(key: "createdDate", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "categories")
        
        fetchedResultsController.delegate = self
        
        refreshTable()
    }
    
    func refreshTable() {
        do {
            try fetchedResultsController.performFetch()
            
            tableView.reloadData()
        } catch {
            fatalError("Fetching categories could not be performed: \(error.localizedDescription)")
        }
    }
    
    func saveCategory(name: String) {
        let category = Category(context: self.dataController.viewContext)
        category.name = name
        
        try? dataController.viewContext.save()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] (action) in
            
            if let name = alert.textFields?.first?.text {
                self?.saveCategory(name: name)
            }
        }
        
        alert.addAction(addAction)
        alert.addTextField { (field) in
            field.placeholder = "Create new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
}
