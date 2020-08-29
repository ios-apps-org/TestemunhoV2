//
//  ItemCell+CreatedDate.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/29/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

extension Item {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        createdDate = Date()
    }
}
