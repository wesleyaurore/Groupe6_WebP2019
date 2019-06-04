//
//  Match.swift
//  Corporate-Cup
//
//  Created by wesley on 01/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

enum MatchStatus {
    case Pending, Running, Finished
}

class Match {
    // Properties
    let id: Int
    let group: Group
    let groupId: Int
    let winner: Int
    let looser: Int
    let status: MatchStatus
    let activity: Activity
    
    // Initialization
    init(id: Int = 0, group: Group, groupId: Int = 0, winner: Int = 0, looser: Int = 0, status: MatchStatus = .Pending, activity: Activity = Activity()) {
        self.id = id
        self.group = group
        self.groupId = groupId
        self.winner = winner
        self.looser = looser
        self.status = status
        self.activity = activity
    }
}
