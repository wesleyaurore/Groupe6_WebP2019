//
//  TournamentService.swift
//  Corporate-Cup
//
//  Created by wesley on 04/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CallbackTournamnent = (_ res: JSON, _ error: Error?) -> Void
typealias CallbackTournamentSummary = (_ res: Any, _ error: Bool) -> Void

class TournamentService {
    static func pendingTournamentAction(callBack: @escaping CallbackTournamnent) {
        Alamofire.request(UrlBuilder.checkPendingTournamentUrl(), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                callBack(json, nil)

            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func tournamentSummaryAction(callBack: @escaping CallbackTournamentSummary) {
        Alamofire.request(UrlBuilder.tournamentSummaryUrl(), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let matchList = setTournament(json: json)
                
                let code = (json["code"].int ?? 200)
                
                let error = code != UrlBuilder.sucessCode ? true : false
                
                callBack(matchList, error)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
}

func setTournament(json: JSON) -> Tournament {
    let tournamentData = json["data"][0]
    
    let tournamentId = tournamentData["id"].int ?? 0
    let tournamentCompanyId = tournamentData["company_id"].int ?? 0
    let tournamentName = tournamentData["name"].string ?? ""
    let tournamentStatusData = tournamentData["status"].string ?? ""
    
    var tournamentStatus: TournamentStatus = .Pending
    
    switch tournamentStatusData {
    case "RUNNING":
        tournamentStatus = .Running
    case "FINISHED":
        tournamentStatus = .Finished
    default:
        break
    }
    
    let tournamentLaunch: String = tournamentData["launch_at"].string ?? ""
    let tournamentPrice = tournamentData["price"].string ?? ""
    
    var groups: [Group] = [Group]()
    
    let groupsData = tournamentData["groups"].array ?? []
    
    for groupData in groupsData {
        let groupId = groupData["id"].int ?? 0
        let groupTournamentId = groupData["tournament_id"].int ?? 0
        let groupName = groupData["name"].string ?? ""
        
        var players: [Player] = [Player]()
        let playersData = groupData["users"].array ?? []
        
        for playerData in playersData {
            let playerId = playerData["id"].int ?? 0
            let playerName = playerData["name"].string ?? ""
            let playerEmail = playerData["email"].string ?? ""
            let playerAvatar = UIImageView()
            let avatarUrl = formatUrl(url: playerData["avatar_url"].string ?? "")
            if avatarUrl == "" {
                playerAvatar.downloaded(from: avatarUrl)
            } else {
                playerAvatar.image = UIImage(named: "default_avatar")
            }
            
            let playerScore = playerData["score"].int ?? 0
            let playerWinningTournament = playerData["winning_tournament"].int ?? 0
            
            let player = Player(id: playerId, name: playerName, email: playerEmail, avatar: playerAvatar, score: playerScore, winningTournament: playerWinningTournament)
            
            players += [player]
        }
        
        let group = Group(id: groupId, tournamentId: groupTournamentId, name: groupName, players: players)
        groups += [group]
    }
    
    return Tournament(id: tournamentId, companyId: tournamentCompanyId, name: tournamentName, status: tournamentStatus, launch: tournamentLaunch, price: tournamentPrice, groups: groups)
}

//func setTournament(json: JSON) -> Tournament {
//    let tournamentId = json["gameInfo"]["tournament"][0]["id"].int ?? 0
//    let tournamentCompanyId = json["gameInfo"]["tournament"][0]["company_id"].int ?? 0
//    let tournamentName = json["gameInfo"]["tournament"][0]["name"].string ?? ""
//    let tournamentStatusData = json["gameInfo"]["tournament"][0]["status"].string ?? ""
//
//    print(tournamentStatusData)
//
//    var tournamentStatus: TournamentStatus = .Pending
//
//    switch tournamentStatusData {
//    case "RUNNING":
//        tournamentStatus = .Running
//    case "FINISHED":
//        tournamentStatus = .Finished
//    default:
//        break
//    }
//
//    let tournamentLaunch: String = json["gameInfo"]["tournament"][0]["launch_at"].string ?? ""
//    let tournamentPrice = json["gameInfo"]["tournament"][0]["price"].string ?? ""
//
//    var groups: [Group] = [Group]()
//    var players = [Player]()
//
//    let groupsData = json["data"][0]["groups"].array ?? []
//
//    for groupData in groupsData {
//        let groupId = groupData["id"].int ?? 0
//        let groupTournamentId = groupData["tournament_id"].int ?? 0
//        let groupName = groupData["name"].string ?? ""
//
//        if groups.map({ $0.name }).firstIndex(of: groupName) == nil {
//            let group = Group(id: groupId, tournamentId: groupTournamentId, name: groupName)
//            groups += [group]
//
//            let playersData = groupData["users"].array ?? []
//
//            for playerData in playersData {
//                let playerId = playerData["id"].int ?? 0
//                let playerName = playerData["name"].string ?? ""
//                let playerEmail = playerData["email"].string ?? ""
//                let playerAvatar = UIImageView()
//                let avatarUrl = formatUrl(url: playerData["avatar_url"].string ?? "")
//                if avatarUrl == "" {
//                    playerAvatar.downloaded(from: avatarUrl)
//                } else {
//                    playerAvatar.image = UIImage(named: "default_avatar")
//                }
//
//                let playerScore = playerData["score"].int ?? 0
//                let playerWinningTournament = playerData["winning_tournament"].int ?? 0
//
//                let player = Player(id: playerId, name: playerName, email: playerEmail, avatar: playerAvatar, score: playerScore, winningTournament: playerWinningTournament)
//
//                players += [player]
//            }
//        }
//    }
//
//    return Tournament(id: tournamentId, companyId: tournamentCompanyId, name: tournamentName, status: tournamentStatus, launch: tournamentLaunch, price: tournamentPrice, groups: groups)
