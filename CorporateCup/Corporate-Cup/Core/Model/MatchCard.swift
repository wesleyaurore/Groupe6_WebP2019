//
//  Card.swift
//  Corporate-Cup
//
//  Created by wesley on 07/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class MatchCard {
    // Properties
    var game: String
    var started: Bool
    var finish: Bool
    var congrat: Bool
    var win: Bool
    var issueCode: Int
    
    // Initialization
    init(game: String, started: Bool, finish: Bool, congrat: Bool, win: Bool, issueCode: Int) {
        self.game = game
        self.started = started
        self.finish = finish
        self.congrat = congrat
        self.win = win
        self.issueCode = issueCode
    }
}
