//
//  Activity.swift
//  Corporate-Cup
//
//  Created by wesley on 01/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class Activity {
    // Properties
    let id: Int
    let name: String
    let rules: String
    let description: String
    
    // Initialization
    init(id: Int = 0, name: String = "", rules: String = "", description: String = "") {
        self.id = id
        self.name = name
        self.rules = rules
        self.description = description
    }
}
