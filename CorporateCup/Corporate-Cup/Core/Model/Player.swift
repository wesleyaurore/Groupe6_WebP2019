//
//  Player.swift
//  Corporate-Cup
//
//  Created by wesley on 01/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class Player {
    // Properties
    let id: Int
    let name: String
    let email: String
    let avatar: UIImageView
    let score: Int
    let winningTournament: Int
    
    // Properties
    init(id: Int = 0, name: String = "", email: String = "", avatar: UIImageView = UIImageView(), score: Int = 0, winningTournament: Int = 0) {
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
        self.score = score
        self.winningTournament = winningTournament
    }
}
