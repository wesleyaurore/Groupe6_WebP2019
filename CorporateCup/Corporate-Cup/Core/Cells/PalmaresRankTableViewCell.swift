//
//  RankingTableViewCell.swift
//  Corporate-Cup
//
//  Created by wesley on 13/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class PalmaresRankTableViewCell: UITableViewCell {
    // Properties
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var star: UIImageView!
    
    let user:User = UserDefaults.getTheUserStored() ?? User()
    
    // Initialization
    func initializeRank(player: Player, rank: Int) {
        switch rank {
        case 1:
            self.rank.backgroundColor = UIColor.FlatColor.sunflower
            self.rank.textColor = UIColor.white
        case 2:
            self.rank.backgroundColor = UIColor.FlatColor.orangePeel
            self.rank.textColor = UIColor.white
        case 3:
            self.rank.backgroundColor = UIColor.FlatColor.grey
            self.rank.textColor = UIColor.white
        default:
            self.rank.backgroundColor = UIColor.FlatColor.acideGrey
            self.rank.textColor = UIColor.FlatColor.darkGrey
        }
        
        if player.id == user.id {
            playerName.font = UIFont.systemFont(ofSize: self.playerName.font.pointSize, weight: .bold)
        }
        
        self.rank.text = String(rank)
        
        avatar = player.avatar
        playerName.text = player.name
        score.text = String(player.score)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        playerName.font = UIFont.systemFont(ofSize: self.playerName.font.pointSize, weight: .regular)
    }
}
