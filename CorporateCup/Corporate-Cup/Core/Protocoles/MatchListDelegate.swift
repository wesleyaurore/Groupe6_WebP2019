//
//  MatchListDelegate.swift
//  Corporate-Cup
//
//  Created by wesley on 08/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

protocol MatchListDelegate: AnyObject {
    func matchStateHandler(sender: UIButton, cell: MatchCardTableViewCell)
    
    func submitIssue(issueCode: Int)
    
    func startMatch()
    
    func submitMatchResult(submit: Bool, win: Bool)
    
    func submitCongrat(badge: Int)
}
