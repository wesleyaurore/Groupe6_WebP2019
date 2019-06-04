//
//  MatchCardTableViewCell.swift
//  Corporate-Cup
//
//  Created by wesley on 08/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class MatchCardTableViewCell: UITableViewCell {
    // Properties
    var delegate: MatchListDelegate?
    let user:User = UserDefaults.getTheUserStored() ?? User()
    
    var match: Match? = nil
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var player1Avatar: UIImageView!
    @IBOutlet weak var player1Name: UILabel!
    @IBOutlet weak var player2Avatar: UIImageView!
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var pendingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var stateButtonView: UIView!
    
    let stateButton = UIButton()
    let issueButton = UIButton()
    
    func initializeMatchCard(match: Match) {
        self.match = match

        let userWin = match.winner == user.id
        
        // Game label
        activityLabel.textStyle(text: match.activity.name, color: UIColor.FlatColor.darkBlue, size: 18, bold: true, capitalizeFirstLetter: true)
        
        // Score label
        scoreLabel.setScoreLabel(status: match.status, winner: userWin)
        
        // Card view
        cardView.addShadow()
        
        // Left player
        player1Avatar = match.group.players[0].avatar
        player1Name.text = match.group.players[0].name
        
        // Right player
        player2Avatar = match.group.players[1].avatar
        player2Name.text = match.group.players[1].name
        
        // Pending label
        pendingLabel.textStyle(text: "En cours", size: 16, bold: true, center: true, adaptive: false)
        
        switch match.status {
        case .Running:
            pendingLabel.isHidden = false
        default:
            pendingLabel.isHidden = true
        }
        
        // Status label
        statusLabel.setStatusLabel(status: match.status, winner: userWin)
        
        //Status button
        stateButtonView.setStateButton(stateButton: stateButton, issueButton: issueButton, status: match.status)
        
        // // add Event handler
        stateButton.addTarget(self, action:#selector(eventHandler), for: .touchUpInside)
        issueButton.addTarget(self, action:#selector(eventHandler), for: .touchUpInside)
    }
    
    func reloadMatchCard(match: Match) {
        self.match = match
        
        let userWin = match.winner == user.id

        // Score label
        scoreLabel.setScoreLabel(status: match.status, winner: userWin)
        
        // Pending label
        switch match.status {
        case .Running:
            pendingLabel.isHidden = false
        default:
            pendingLabel.isHidden = true
        }
        
        // Status label
        statusLabel.setStatusLabel(status: match.status, winner: userWin)
        
        // Status Button
        stateButtonView.setStateButton(stateButton: stateButton, issueButton: issueButton,status: match.status)
    }
    
    @objc func eventHandler(_ sender: UIButton) {
        if sender.tag < 3 {
            self.delegate?.matchStateHandler(sender: sender, cell: self)
        }
    }
}
