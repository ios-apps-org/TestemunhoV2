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

extension CategoryViewController {
    
    // MARK: - DataSource Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.defaultReuseIdentifier, for: indexPath) as! CategoryCell
        
        if let category = categories?[indexPath.row] {
            let count = category.items.count
            var itemString = count == 1 ? "1 item" : "\(count) items"
            if count == 0 {
                itemString = "no items"
            }
            cell.itemCountLabel.text = itemString
        }
        
        cell.nameLabel?.text = categories?[indexPath.row].name ?? "No categories added yet."
        
        return cell
    }

    
    // MARK: - Delegate Functions
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "itemsSegue", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destVC.selectedCategory = categories?[indexPath.row]
        }
    }
}
