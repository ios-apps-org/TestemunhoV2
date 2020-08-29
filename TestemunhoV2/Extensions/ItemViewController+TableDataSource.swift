//
//  CategoryViewController+TableDataSource.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource

extension ItemViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.defaultReuseIdentifier, for: indexPath) as! ItemCell
        
        let item = itemArray[indexPath.row]
        
        if let createdDate = item.createdDate {
            cell.dateLabel?.text = self.dateFormatter.string(from: createdDate)
        }
        cell.titleLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
}
