//
//  MatchListViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 26/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class MatchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MatchListDelegate {
    // Properties
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var matchTableView: UITableView!
    
    var loader: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let statusView = UIView()
    let statusButton = UIButton()
    
    var matchList: MatchList? = nil
    
    var currentMatch: Match? = nil
    
    let user:User = UserDefaults.getTheUserStored() ?? User()
    
    // // Delegate
    weak var delegate: MatchCardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.FlatColor.lightGrey
        
        self.matchTableView.allowsSelection = false
        self.matchTableView.dataSource = self
        self.matchTableView.delegate = self
        
        self.loader = basicLoader
        
        self.view.addSubview(statusView)
        self.view.bringSubviewToFront(segmentedControl)
        
        loadPendingGames()
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            loadPendingGames()
        case 1:
            loadRunningGames()
        case 2:
            loadFinishedGames()
        default:
            break
        }
    }
    
    
    // Table view data source
    
    // // Section
    func numberOfSections(in tableView: UITableView) -> Int {
        if matchList != nil {
            return matchList!.groups.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        if self.matchList != nil {
            let padding = CGFloat(20)
            view.backgroundColor = UIColor.white
            
            let label = UILabel()
            label.frame = CGRect(x: padding, y: label.frame.minY + padding / 2, width: label.frame.width, height: label.frame.height)
            label.text = self.matchList!.groups[section].name
            label.textStyle(color: UIColor.FlatColor.darkBlue, size: 22, bold: true)
            view.addSubview(label)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let padding = CGFloat(20)
        
        return tableView.sectionHeaderHeight + padding
    }
    
    // // Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if matchList != nil {
            let currentGroup = matchList?.groups[section]
            return matchList?.matchs.filter({ $0.group.name == currentGroup?.name }).count ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.matchTableView.dequeueReusableCell(withIdentifier: "matchCardCell", for: indexPath) as! MatchCardTableViewCell
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        if matchList != nil {
            let currentGroup = matchList?.groups[indexPath.section]
            let currentMatchs = matchList?.matchs.filter({ $0.group.name == currentGroup?.name })
            let match = currentMatchs![indexPath.row]
            
            cell.delegate = self
            cell.initializeMatchCard(match: match)
        }
        
        return cell
    }
    
    // Listen Event
    func matchStateHandler(sender: UIButton, cell: MatchCardTableViewCell) {
        currentMatch = cell.match
        
        switch sender.tag {
        case -1:
            showIssueModal()

        case 0:
            showMatchStartModal()

        case 1:
            showMatchResultModal()
            
        case 2:
            showCongratModal()

        default:
            break
        }
    }
    
    // Delegate Handler
    func submitIssue(issueCode: Int) {
        
    }
    
    func startMatch() {
        MatchService.gameStartAction(id: self.currentMatch!.id){ (res, error) in
            if res["message"] == "game status changed" {
                self.showUpdatedStatusModal(parent: self.presentedViewController!, image: "team_work", info: "La partie Commence !", message: "Que le meilleur gagne !!", buttonTitle: "C'est parti")
                
                self.segmentedControl.selectedSegmentIndex = 1
                self.loadRunningGames()
            } else {
                self.showUpdatedStatusModal(parent: self.presentedViewController!, image: "presentation", info: "Oops !! Il semble qu'il y est eu un problème", buttonTitle: "Ok")
            }
        }
    }

    func submitMatchResult(submit: Bool, win: Bool) {
        let message = win ? "Bien joué vous êtes un champion !" : "Vous ferez mieux la prochaine fois :)"
        
        let otherPlayer = currentMatch!.group.players[0].id != user.id ? currentMatch!.group.players[0].id : currentMatch!.group.players[1].id
        
        var winner = user.id
        var looser = otherPlayer
        
        if !win {
            winner = otherPlayer
            looser = user.id
        }
        
        let params: [String: Any] = [
            "winner": winner,
            "looser": looser
        ]

        MatchService.gameEndAction(id: self.currentMatch!.id, body: params){ (res, error) in
            if res["message"] == "game  finished" {
                self.showUpdatedStatusModal(parent: self.presentedViewController!, image: "presentation", info: "Résultat Envoyé", message: message, buttonTitle: "Ok")
                
                self.matchTableView.isHidden = true
                self.segmentedControl.selectedSegmentIndex = 2
                self.loadFinishedGames()
            } else {
                self.showUpdatedStatusModal(parent: self.presentedViewController!, image: "presentation", info: "Oops !! Il semble qu'il y est eu un problème", buttonTitle: "Ok")
            }
        }
    }

    func submitCongrat(badge: Int) {
        MatchService.addBadgeAction(id: self.currentMatch!.id, badge: badge){ (res, error) in
            print(res)
            if res["message"] == "game status changed" {
                self.showUpdatedStatusModal(parent: self.presentedViewController!, image: "team_work", info: "Envoie badge", message: "Vous avez envoyé 1 nouveau badge. Bien joué ! C’est sport !", buttonTitle: "Ok")
            } else {
                self.showUpdatedStatusModal(parent: self.presentedViewController!, image: "presentation", info: "Oops !! Il semble qu'il y est eu un problème", buttonTitle: "Ok")
            }
        }
    }
    
    // Modals
    func showIssueModal() {
        let modal = IssuesModalViewController()
        modal.delegate = self
        modal.showModal(parent: self)
    }
    
    func showMatchStartModal() {
        let modal = MatchStartModalViewController()
        modal.provideRules(match: currentMatch!)
        modal.delegate = self
        modal.showModal(parent: self)
    }
    
    func showMatchResultModal() {
        let modal = MatchResultModalViewController()
        modal.delegate = self
        modal.showModal(parent: self)
    }
    
    func showCongratModal() {
        let modal = CongratModalViewController()
        modal.delegate = self
        modal.showModal(parent: self)
    }
    
    func showUpdatedStatusModal(parent: UIViewController, image: String, info: String, message: String? = "", buttonTitle: String) {
        let modal = UpdatedStatusModalViewController()
        modal.initModal(parent: parent, image: image, info: info, message: message!, buttonTitle: buttonTitle)
        modal.showModal(parent: parent)
    }
    
    // Initialize Data
    private func loadPendingGames() {
        self.matchList = nil
        self.displayGames()
        
        loadingGames()
        
        MatchService.gamesPendingAction(){ (res, error) in
            if error {
                self.statusView.isHidden = false
                self.statusView.status(image: "presentation", info: "Oops !! Il semble qu'il y est eu un problème")
            } else {
                let matchList = (res as! MatchList)
                
                if matchList.games == 0 {
                    self.noDisplayedGames()
                    self.statusView.status(image: "presentation", info: "Vous n’avez aucun match à venir", button: self.statusButton, buttonTitle: "Voir prochain tournoi")
                } else {
                    self.matchList = matchList
                    self.displayGames()
                }
            }
        }
    }
    
    private func loadRunningGames() {
        loadingGames()
        
        MatchService.gamesRunningAction(){ (res, error) in
            if error {
                self.statusView.isHidden = false
                self.statusView.status(image: "presentation", info: "Oops !! Il semble qu'il y est eu un problème")
            } else {
                let matchList = (res as! MatchList)

                if matchList.games == 0 {
                    self.noDisplayedGames()
                    self.statusView.status(image: "presentation", info: "Vous n’avez aucun match en cours")
                } else {
                    self.matchList = matchList
                    self.displayGames()
                }
            }
        }
    }
    
    private func loadFinishedGames() {
        loadingGames()
        
        MatchService.gamesFinishedAction(){ (res, error) in
            if error {
                self.statusView.isHidden = false
                self.statusView.status(image: "presentation", info: "Oops !! Une erreur est subvenue.")
            } else {
                let matchList = (res as! MatchList)
                
                if matchList.games == 0 {
                    self.noDisplayedGames()
                    self.statusView.status(image: "presentation", info: "Vous n’avez aucun match terminé")
                } else {
                    self.matchList = matchList
                    self.displayGames()
                }
            }
        }
    }
    
    func loadingGames() {
        self.loader.startAnimating()
        self.segmentedControl.isHidden = false
        self.matchTableView.isHidden = true
        self.statusView.isHidden = true
    }
    
    func noDisplayedGames() {
        loader.stopAnimating()
        self.segmentedControl.isHidden = false
        self.matchTableView.isHidden = true
        self.statusView.isHidden = false
    }
    
    func displayGames() {
        loader.stopAnimating()
        self.statusView.isHidden = true
        self.segmentedControl.isHidden = false
        self.matchTableView.isHidden = false
        self.matchTableView.reloadData()
    }
}
