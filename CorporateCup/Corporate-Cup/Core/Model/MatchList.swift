//
//  MatchList.swift
//  Corporate-Cup
//
//  Created by wesley on 01/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class MatchList {
    let tournament: Tournament
    let games: Int
    let groups: [Group]
    let matchs: [Match]
    
    init(tournament: Tournament, games: Int = 0, groups: [Group], matchs: [Match]){
        self.tournament = tournament
        self.games = games
        self.groups = groups
        self.matchs = matchs
    }
}
