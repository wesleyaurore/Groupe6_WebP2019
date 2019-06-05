//
//  Tournament.swift
//  Corporate-Cup
//
//  Created by wesley on 31/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

enum TournamentStatus {
    case Pending, Running, Finished
}

class Tournament {
    // Properties
    let id: Int
    let companyId: Int
    let name: String
    let status: TournamentStatus
    let launch: String
    let price: String
    let groups: [Group]
    
    // Initialization
    init(id: Int = 0, companyId: Int = 0, name: String = "", status: TournamentStatus = .Pending, launch: String = "", price: String = "", groups: [Group]? = [Group]()) {
        self.id = id
        self.companyId = companyId
        self.name = name
        self.status = status
        self.launch = launch
        self.price = price
        self.groups = groups!
    }
}
