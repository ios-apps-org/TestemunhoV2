//
//  CategoryViewController+TableDataSource.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/28/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

// MARK: - UITableViewDataSource

import UIKit

extension CategoryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.defaultReuseIdentifier, for: indexPath) as! CategoryCell
        
        let category = categories[indexPath.row]
        
        let count = category.items?.count
        var itemString = count == 1 ? "1 item" : "\(count!) items"
        if count == 0 {
            itemString = "no items"
        }
        cell.itemCountLabel.text = itemString
        cell.nameLabel?.text = category.name
        
        return cell
    }
}
