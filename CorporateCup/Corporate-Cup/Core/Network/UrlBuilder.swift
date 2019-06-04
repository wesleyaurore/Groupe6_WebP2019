//
//  URLBuilder.swift
//  Corporate-Cup
//
//  Created by wesley on 17/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import Foundation

class UrlBuilder {
    static let errorCode = 400
    static let sucessCode = 200
    
    private static let baseUrl: String = {
        return "http://apicorporatecup.herokuapp.com/api"
    }()
    
    static func mailCheckUrl() -> String {
        return "\(baseUrl)/auth/checkemail"
    }
    
    static func loginUrl() -> String {
        return "\(baseUrl)/auth/login"
    }
    
    static func finishRegisterUrl() -> String {
        return "\(baseUrl)/auth/finishRegister"
    }
    
    static func gamesPendingUrl() -> String {
        return "\(baseUrl)/app/user/gamesPending"
    }
    
    static func gamesRunningUrl() -> String {
        return "\(baseUrl)/app/user/gamesRunning"
    }
    
    static func gamesFinishedUrl() -> String {
        return "\(baseUrl)/app/user/gamesFinished"
    }
    
    static func gameStartUrl(id: String) -> String {
        return "\(baseUrl)/app/user/\(id)/gameStart"
    }
    
    static func gameEndUrl(id: String) -> String {
        return "\(baseUrl)/app/user/\(id)/gameEnd"
    }
    
    static func badgesUrl() -> String {
        return "\(baseUrl)/app/badges"
    }
    
    static func addBadgeUrl(id: String, badge: String) -> String {
        return "\(baseUrl)/app/user/\(id)/badge/\(badge)"
    }
    
    static func checkPendingTournamentUrl() -> String {
        return "\(baseUrl)/app/tournament"
    }
    
    static func tournamentSummaryUrl() -> String {
        return "\(baseUrl)/app/tournament/summary"
    }
}
