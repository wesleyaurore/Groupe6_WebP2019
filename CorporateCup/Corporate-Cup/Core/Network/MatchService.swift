//
//  MatchService.swift
//  Corporate-Cup
//
//  Created by wesley on 28/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CallbackGame = (_ res: Any, _ error: Bool) -> Void
typealias CallbackGameStart = (_ res: JSON, _ error: Error?) -> Void

class MatchService {
    static func gamesPendingAction(callBack: @escaping CallbackGame) {
        Alamofire.request(UrlBuilder.gamesPendingUrl(), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let matchList = setMatchList(json: json)
                
                let code = (json["code"].int ?? 200)
                
                let error = code != UrlBuilder.sucessCode ? true : false
                
                callBack(matchList, error)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func gamesRunningAction(callBack: @escaping CallbackGame) {
        Alamofire.request(UrlBuilder.gamesRunningUrl(), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let matchList = setMatchList(json: json)
                
                let code = (json["code"].int ?? 200)
                
                let error = code != UrlBuilder.sucessCode ? true : false
                
                callBack(matchList, error)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func gamesFinishedAction(callBack: @escaping CallbackGame) {
        Alamofire.request(UrlBuilder.gamesFinishedUrl(), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                let matchList = setMatchList(json: json)
                
                let code = (json["code"].int ?? 200)
                
                let error = code != UrlBuilder.sucessCode ? true : false
                
                callBack(matchList, error)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func gameStartAction(id: Int, callBack: @escaping CallbackGameStart) {
        Alamofire.request(UrlBuilder.gameStartUrl(id: String(id)), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
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

    static func gameEndAction(id: Int, body: [String : Any], callBack: @escaping CallbackGameStart) {
        Alamofire.request(UrlBuilder.gameEndUrl(id: String(id)), method: .put, parameters: body, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
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
    
    static func getBadgesAction(callBack: @escaping CallbackGame) {
        Alamofire.request(UrlBuilder.badgesUrl(), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var badges = [Badge]()
                
                let badgesData = json["data"].array ?? []
                
                for badgeData in badgesData {
                    let id = badgeData["id"].int ?? 0
                    let title = badgeData["title"].string ?? ""
                    let image = title != "" ? "badge_\(title)" : ""
                    
                    let badge = Badge(id: id, title: title, image: image)
                    
                    badges += [badge]
                }
                
                let code = (json["code"].int ?? 200)
                
                let error = code != UrlBuilder.sucessCode ? true : false
                
                callBack(badges, error)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func addBadgeAction(id: Int, badge: Int, callBack: @escaping CallbackGameStart) {
        Alamofire.request(UrlBuilder.addBadgeUrl(id: String(id), badge: String(badge)), method: .get, encoding: JSONEncoding.default, headers: AuthService.getHeadersAction()).responseString(completionHandler: { response in
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

func setMatchList(json: JSON) -> MatchList {
    let tournamentId = json["gameInfo"]["tournament"][0]["id"].int ?? 0
    let tournamentCompanyId = json["gameInfo"]["tournament"][0]["company_id"].int ?? 0
    let tournamentName = json["gameInfo"]["tournament"][0]["name"].string ?? ""
    let tournamentStatusData = json["gameInfo"]["tournament"][0]["status"].string ?? ""
    
    var tournamentStatus: TournamentStatus = .Pending
    
    switch tournamentStatusData {
    case "RUNNING":
        tournamentStatus = .Running
    case "FINISHED":
        tournamentStatus = .Finished
    default:
        break
    }
    
    let tournamentLaunch: String = json["gameInfo"]["tournament"][0]["launch_at"].string ?? ""
    let tournamentPrice = json["gameInfo"]["tournament"][0]["price"].string ?? ""
    
    let tournament = Tournament(id: tournamentId, companyId: tournamentCompanyId, name: tournamentName, status: tournamentStatus, launch: tournamentLaunch, price: tournamentPrice)
    
    let games = json["data"]["meta"]["games"].int ?? 0
    
    var groups = [Group]()
    
    var matchs = [Match]()
    
    let matchsData = json["data"]["data"].array ?? []
    
    for matchData in matchsData {
        let matchId = matchData["id"].int ?? 0
        let matchGroupId = matchData["group_id"].int ?? 0
        let matchWinner = matchData["winner"].int ?? 0
        let matchLooser = matchData["looser"].int ?? 0
        var matchStatus: MatchStatus = .Pending
        
        switch matchData["status"].string {
        case "RUNNING":
            matchStatus = .Running
        case "FINISHED":
            matchStatus = .Finished
        default:
            break
        }
        
        let groupId = matchData["group"]["id"].int ?? 0
        let groupTournamentId = matchData["group"]["tournament_id"].int ?? 0
        let groupName = matchData["group"]["name"].string ?? ""
        
        let activityId = matchData["activity"]["id"].int ?? 0
        let activityName = matchData["activity"]["name"].string ?? ""
        let activityRules = matchData["activity"]["rules"].string ?? ""
        let activityDescription = matchData["activity"]["description"].string ?? ""
        
        let activity = Activity(id: activityId, name: activityName, rules: activityRules, description: activityDescription)
        
        var players = [Player]()
        
        let playersData = matchData["users"].array ?? []
        
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
        
        if groups.map({ $0.name }).firstIndex(of: group.name) == nil {
            groups += [group]
        }
        
        let match = Match(id: matchId, group: group, groupId: matchGroupId, winner: matchWinner, looser: matchLooser, status: matchStatus, activity: activity)
        
        matchs += [match]
    }
    
    return MatchList(tournament: tournament, games: games, groups: groups, matchs: matchs)
}

func formatUrl(url: String) -> String {
    return url.replacingOccurrences(of: "\\", with: "")
}
