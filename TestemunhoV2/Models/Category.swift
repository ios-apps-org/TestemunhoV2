//
//  Category.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 10/3/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import RealmSwift

class Category: Object {
    /*
        Note: dynamic (declaration modifier),
              tells runtime to use dynamic dispatch over standard (static dispatch)
            allows property to be monitored for change
            i.e. user changes property value at runtime (while app is running),
            allows realm to dynamically update changes in database
            but dynamic dispatch comes from Objective-C APIs
     */
    @objc dynamic var color: String = ""
    @objc dynamic var createdDate: Date?
    @objc dynamic var name: String = ""
    
    // forward relationship
    let items = List<Item>()
}
