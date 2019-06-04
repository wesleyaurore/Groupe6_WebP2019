//
//  TournamentRankTableViewCell.swift
//  Corporate-Cup
//
//  Created by wesley on 04/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class TournamentRankTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var border: UIView!
    
    let user:User = UserDefaults.getTheUserStored() ?? User()
    
    func initializeRow(player: Player, leader: Bool) {
        self.avatar = player.avatar
        self.playerName.text = player.name
        
        if user.id == player.id {
            self.playerName.font = UIFont.systemFont(ofSize: self.playerName.font.pointSize, weight: .bold)
        }
        
        self.score.text = "\(String(player.score)) pts"
        
        if leader {
            self.score.textColor = UIColor.FlatColor.sunflower
            self.border.backgroundColor = UIColor.FlatColor.sunflower
        }
    }
    
    override func prepareForReuse() {
        self.playerName.font = UIFont.systemFont(ofSize: self.playerName.font.pointSize, weight: .regular)
        self.score.textColor = UIColor.black
        self.border.backgroundColor = UIColor(white: 0, alpha: 0)
    }

}
