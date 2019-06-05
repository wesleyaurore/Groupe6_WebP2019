//
//  PalmaresService.swift
//  Corporate-Cup
//
//  Created by wesley on 05/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CallbackPalmares = (_ res: Any, _ error: Bool) -> Void

class PalmaresService {
    static func palmaresAction(callBack: @escaping CallbackPalmares) {
        Alamofire.request(UrlBuilder.palmaresUrl(), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var players: [Player] = [Player]()
                
                let playersData = json["data"].array ?? []
                
                for playerData in playersData {
                    let playerId = playerData["id"].int ?? 0
                    let playerName = playerData["name"].string ?? ""
                    let playerEmail = playerData["email"].string ?? ""
                    let playerAvatar = UIImageView()
                    let avatarUrl = formatUrl(url: playerData["avatar_url"].string ?? "")
                    if avatarUrl != "" {
                        playerAvatar.downloaded(from: avatarUrl)
                    } else {
                        playerAvatar.image = UIImage(named: "default_avatar")
                    }
                    
                    let playerScore = playerData["score"].int ?? 0
                    let playerWinningTournament = playerData["winning_tournament"].int ?? 0
                    
                    let player = Player(id: playerId, name: playerName, email: playerEmail, avatar: playerAvatar, score: playerScore, winningTournament: playerWinningTournament)
                    
                    players += [player]
                }
                
                let code = (json["code"].int ?? 200)
                
                let error = code != UrlBuilder.sucessCode ? true : false
                
                callBack(players, error)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
}
