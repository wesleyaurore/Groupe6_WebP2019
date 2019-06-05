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

typealias CallbackTournament = (_ res: Any, _ error: Bool) -> Void
typealias CallbackTournamentChangedStatus = (_ res: JSON, _ error: Error?) -> Void

class TournamentService {
    static func pendingTournamentAction(callBack: @escaping CallbackTournament) {
        Alamofire.request(UrlBuilder.checkPendingTournamentUrl(), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)

                let tournamentData = json["data"]["data"][0]
                let groupsData = json["included"]["groups"]
                let playersData = "user"

                let tournament = setTournament(tournamentData: tournamentData, groupsData: groupsData, playersData: playersData)

                let code = (json["code"].int ?? 200)
                
                let error = code != UrlBuilder.sucessCode ? true : false
                
                callBack(tournament, error)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func tournamentSummaryAction(callBack: @escaping CallbackTournament) {
        Alamofire.request(UrlBuilder.tournamentSummaryUrl(), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let tournamentData = json["data"][0]
                let groupsData = tournamentData["groups"]
                let playersData = "users"
        
                let tournament = setTournament(tournamentData: tournamentData, groupsData: groupsData, playersData: playersData)
                
                let code = (json["code"].int ?? 200)
                
                let error = code != UrlBuilder.sucessCode ? true : false
                
                callBack(tournament, error)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func joinTournamentAction(id: Int, callBack: @escaping CallbackTournamentChangedStatus) {
        Alamofire.request(UrlBuilder.joinTournamentUrl(id: String(id)), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
            
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
    
    static func leaveTournamentAction(id: Int, callBack: @escaping CallbackTournamentChangedStatus) {
        Alamofire.request(UrlBuilder.leaveTournamentUrl(id: String(id)), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
            
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
}

func setTournament(tournamentData: JSON, groupsData: JSON, playersData: String) -> Tournament {
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
    
    for groupData in groupsData.array ?? [] {
        let groupId = groupData["id"].int ?? 0
        let groupTournamentId = groupData["tournament_id"].int ?? 0
        let groupName = groupData["name"].string ?? ""
        
        var players: [Player] = [Player]()
        
        let playersData = groupData[playersData].array ?? []
        
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
        
        let group = Group(id: groupId, tournamentId: groupTournamentId, name: groupName, players: players)
        groups += [group]
    }
    
    return Tournament(id: tournamentId, companyId: tournamentCompanyId, name: tournamentName, status: tournamentStatus, launch: tournamentLaunch, price: tournamentPrice, groups: groups)
}


