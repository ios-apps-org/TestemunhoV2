//
//  Item.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 10/3/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import RealmSwift

class Item: Object {
    /*
        Note: dynamic (declaration modifier),
              tells runtime to use dynamic dispatch over standard (static dispatch)
            allows property to be monitored for change
            i.e. user changes property value at runtime (while app is running),
            allows realm to dynamically update changes in database
            but dynamic dispatch comes from Objective-C APIs
     */
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var createdDate: Date? = Date()
    
    // Note: auto-updating container
    //       represents object(s) linked to its owning model object
    // inverse relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
