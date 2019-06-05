//
//  Group.swift
//  Corporate-Cup
//
//  Created by wesley on 01/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class Group {
    let id: Int
    let tournamentId: Int
    let name: String
    let players: [Player]
    
    init(id: Int = 0, tournamentId: Int = 0, name: String = "", players: [Player] = [Player]()) {
        self.id = id
        self.tournamentId = tournamentId
        self.name = name
        self.players = players
    }
}
