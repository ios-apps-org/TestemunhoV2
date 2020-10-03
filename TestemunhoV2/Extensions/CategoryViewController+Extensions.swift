//
//  CategoryViewController+TableDataSource.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/28/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

// MARK: - UITableViewDataSource

import ChameleonFramework
import UIKit

extension CategoryViewController {

    // MARK: - DataSource Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            let count = category.items.count
            var itemString = count == 1 ? "1 item" : "\(count) items"
            if count == 0 {
                itemString = "no items"
            }
            cell.detailTextLabel?.text = itemString
            
            cell.textLabel?.text = category.name
            
            guard let color = UIColor(hexString: category.color) else { fatalError() }
            
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            cell.detailTextLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        } else {
            cell.textLabel?.text = "No categories added yet."
            cell.backgroundColor = UIColor(hexString: "1d9bf6")
        }
        
        return cell
    }

    
    // MARK: - Delegate Functions
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "itemsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destVC.selectedCategory = categories?[indexPath.row]
        }
    }
}
