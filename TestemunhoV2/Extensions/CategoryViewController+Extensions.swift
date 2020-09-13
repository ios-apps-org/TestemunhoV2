//
//  CategoryViewController+TableDataSource.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/28/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

// MARK: - UITableViewDataSource

import CoreData
import UIKit

extension CategoryViewController: NSFetchedResultsControllerDelegate {
    
    // MARK: - DataSource methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = fetchedResultsController.object(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.defaultReuseIdentifier, for: indexPath) as! CategoryCell
        
        let count = category.items?.count
        var itemString = count == 1 ? "1 item" : "\(count!) items"
        if count == 0 {
            itemString = "no items"
        }
        cell.itemCountLabel.text = itemString
        cell.nameLabel?.text = category.name
        
        return cell
    }
    
    
    // MARK: - Delete methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "gotoItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destVC.dataController = dataController
            destVC.selectedCategory = fetchedResultsController.object(at: indexPath)
        }
    }
    
    
    // MARK: - NSFetchedResultsControllerDelegate methods
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case.move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        default:
            tableView.reloadData()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .fade)
        case .delete:
            tableView.deleteSections(indexSet, with: .fade)
        case .update:
            tableView.reloadSections(indexSet, with: .fade)
        default:
            tableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        onContentUpdated?()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
}
