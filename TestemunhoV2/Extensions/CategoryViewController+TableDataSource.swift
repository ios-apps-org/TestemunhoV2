//
//  CategoryViewController+TableDataSource.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource

extension CategoryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Note: cellForRowAt indexPath gets called initially when the table gets loaded
        // at that time point none of the items are ready
        // Fix: tableView.reloadData() at didSelectRowAt indexPath
        
        // let cellReuse = UITableViewCell(style: .default, reuseIdentifier: "categoryCell")
        
        // Note: cells roll off and get re-used
        // Bug: in large list, re-used cell might retain state
        // Fix: do not set property on cell, set it on data (Item)
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
}
