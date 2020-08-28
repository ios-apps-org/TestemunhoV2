//
//  CategoryViewController+TableDelegate.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate

extension CategoryViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Note: only reflected in itemArray
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
