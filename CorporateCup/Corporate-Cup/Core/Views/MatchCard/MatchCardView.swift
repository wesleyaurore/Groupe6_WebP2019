//
//  MatchCardView.swift
//  Corporate-Cup
//
//  Created by wesley on 08/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class MatchCardView: UIView {
    // Properties
//    var cell: MatchCardTableViewCell?
//    var matchCard: MatchCard
//    var game: String
//    var started: Bool
//    var finish: Bool
//    var congrat: Bool
//    var win: Bool
//    
//    var sportName = UILabel()
//    var score = UILabel()
//    var ghostCard = UIView()
//    var card = UIView()
//    var leftPlayer = UIView()
//    var rightPlayer = UIView()
//    var resultLabel = UILabel()
//    var pendingLabel = UILabel()
//    var contextualButtonView = UIView()
//    var stateButton = UIButton()
//    var issueButton = UIButton()
//    
//    let padding = CGFloat(20)
//    let fontHeight = CGFloat(40)
//    let profilWidth = CGFloat(70)
//    
//    init(cell: MatchCardTableViewCell, matchCard: MatchCard) {
//        self.cell = cell
//        self.matchCard = matchCard
//        self.game = matchCard.game
//        self.started = matchCard.started
//        self.finish = matchCard.finish
//        self.congrat = matchCard.congrat
//        self.win = matchCard.win
//        
//        super.init(frame: cell.frame)
//        
//        initialize()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func didMoveToSuperview(){
//        
//    }
//    
//    func initialize() {
////        print(self.matchCard.started)
//        // Sport Name Label
//        sportName.textStyle(text: game, color: UIColor.FlatColor.darkBlue, size: 18, bold: true)
//        sportName.frame = CGRect(x: padding, y: padding, width: sportName.frame.width, height: fontHeight)
//        self.addSubview(sportName)
//        
//        // Score Label
//        if finish {
////            score.score(win: win)
//            score.frame = CGRect(x: self.frame.width - score.frame.width - padding, y: padding, width: score.frame.width, height: fontHeight)
//            self.addSubview(score)
//        }
//        
//        // Card Style
//        ghostCard.frame = CGRect(x: self.frame.minX + padding, y: sportName.frame.maxY, width: self.frame.width - padding * 2, height: self.frame.height - padding * 2 - sportName.frame.height)
////        self.addShadow(parent: ghostCard, card: card)
//        self.addSubview(ghostCard)
//        
//        // Left player
//        leftPlayer.frame = CGRect(x: padding, y: padding, width: profilWidth, height: leftPlayer.frame.height)
//        leftPlayer.player(player: match.player)
//        ghostCard.addSubview(leftPlayer)
//        
//        // Right player
//        rightPlayer.frame = CGRect(x: ghostCard.frame.width - profilWidth - padding, y: padding, width: profilWidth, height: rightPlayer.frame.height)
//        rightPlayer.player(name: "Lowkey", photo: "player")
//        ghostCard.addSubview(rightPlayer)
//        
//        // Result Label
////        resultLabel.resultLabel(finish: finish, win: win)
//        resultLabel.frame = CGRect(x: ghostCard.frame.width / 2 - resultLabel.frame.width / 2, y: fontHeight, width: resultLabel.frame.width, height: fontHeight)
//        card.addSubview(resultLabel)
//        
//        // Pending Label
//        if started == true && finish == false {
//            pendingLabel.textStyle(text: "En cours", size: 16, bold: true, center: true)
//            pendingLabel.frame = CGRect(x: ghostCard.frame.width / 2 - pendingLabel.frame.width / 2, y: 0, width: pendingLabel.frame.width, height: fontHeight)
//            ghostCard.addSubview(pendingLabel)
//        }
//        
//        // Contextual button
//        contextualButtonView.frame = CGRect(x: 0, y: ghostCard.frame.height - fontHeight, width: ghostCard.frame.width, height: fontHeight)
////        contextualButtonView.contextualButton(stateButton: stateButton, issueButton: issueButton, started: started, finish: finish, congrat: congrat)
//        ghostCard.addSubview(contextualButtonView)
//        
//        // // add Event handler
//        stateButton.addTarget(self, action:#selector(handler), for: .touchUpInside)
//        issueButton.addTarget(self, action:#selector(handler), for: .touchUpInside)
//    }
//    
//    @objc func handler(_ sender: UIButton) {
//        if sender.tag < 3 {
////            cell?.delegate?.matchStateHandler(sender: sender, cell: cell!)
//        }
//    }
}
