//
//  Item.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

// Item is able to encode itself into a plist or json
// All properties must have standard data types to be encodable
struct Item: Codable {
    
    var title: String = ""
    var done: Bool = false
}
