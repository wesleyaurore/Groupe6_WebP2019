//
//  Badge.swift
//  Corporate-Cup
//
//  Created by wesley on 03/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

class Badge {
    let id: Int
    let title: String
    let image: String
    
    init(id: Int = 0, title: String = "", image: String = "") {
        self.id = id
        self.title = title
        self.image = image
    }
}
