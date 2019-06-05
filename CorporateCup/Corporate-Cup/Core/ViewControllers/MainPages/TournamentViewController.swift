//
//  TournamentViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 30/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class TournamentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TournamentDelegate {
    // Properties
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tournamentName: UILabel!
    @IBOutlet weak var tournamentTableView: UITableView!
    
    let statusView = UIView()
    let statusButton = UIButton()
    var loader: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var tournament: Tournament? = nil
    
    @objc func rightButtonAction() {
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customView:UIView = UIView()
        customView.backgroundColor = .green
        customView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let item = UIBarButtonItem(customView: customView)
        self.navigationController?.navigationItem.rightBarButtonItem?.title = "profil"
        
        self.navigationController?.navigationBar.topItem?.title = "Tournois"
        
        self.view.backgroundColor = UIColor.FlatColor.lightGrey
        self.mainView.backgroundColor = UIColor.FlatColor.lightGrey
        self.tournamentTableView.backgroundColor = UIColor.FlatColor.lightGrey
        
        self.tournamentTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tournamentTableView.allowsSelection = false
        
        self.tournamentTableView.dataSource = self
        self.tournamentTableView.delegate = self
        
        self.mainView.isHidden = true

        self.view.addSubview(statusView)
        loader = basicLoader
        
        loadingTournament()
        
        TournamentService.pendingTournamentAction(){ (res, error) in
            if error {
                self.loader.stopAnimating()
                self.statusView.isHidden = false
                self.statusView.status(image: "presentation", info: "Oops !! Il semble qu'il y est eu un problème")
            } else {
                self.tournament = (res as! Tournament)
                self.loader.stopAnimating()
                
                if self.tournament?.status == .Pending {
                    self.statusView.status(image: "presentation", info: "Le tournoi commence bientôt !", button: self.statusButton, buttonTitle: "Voir les Infos")
                    self.statusView.isHidden = false

                    self.statusButton.addTarget(self, action:#selector(self.statusActionHandler), for: .touchUpInside)
                } else {
                    self.statusView.isHidden = false
                    self.statusView.status(image: "presentation", info: "Aucun tournoi n'est prévu pour le moment")
                }
            }
        }
        
        TournamentService.tournamentSummaryAction(){ (res, error) in
            if error {
                self.statusView.isHidden = false
                self.statusView.status(image: "presentation", info: "Oops !! Il semble qu'il y est eu un problème")
            } else {
                self.tournament = (res as! Tournament)
                
                if self.tournament!.status == .Running {
                    self.tournamentName.text = self.tournament?.name
                    self.displayTournament()
                }
            }
        }
    }
    
    // Table view data source
    
    // // Section
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.tournament != nil {
            return tournament!.groups.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        if self.tournament != nil {
            let padding = CGFloat(20)
            view.backgroundColor = UIColor.FlatColor.lightGrey
            
            let label = UILabel()
            label.frame = CGRect(x: 0, y: label.frame.minY + padding / 2, width: label.frame.width, height: label.frame.height)
            label.text = self.tournament!.groups[section].name
            label.textStyle(color: UIColor.black, size: 20)
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
        if tournament != nil {
            return (tournament?.groups[section].players.count)!
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tournamentTableView.dequeueReusableCell(withIdentifier: "tournamentRankCell", for: indexPath) as! TournamentRankTableViewCell
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        if tournament != nil {
            let sortedPlayers = tournament!.groups[indexPath.section].players.sorted(by: { $0.score > $1.score })
            
            let currentPlayer = sortedPlayers[indexPath.row]
            let isLeader = currentPlayer.id == sortedPlayers[0].id || currentPlayer.id == sortedPlayers[1].id
            cell.initializeRow(player: currentPlayer, leader: isLeader)
        }
        
        return cell
    }
    
    // Actions
    @objc func statusActionHandler() {
        showIssueModal()
    }
    
    func tournamentAction(action: TournamentAction) {
        switch action {
        case .Join:
            TournamentService.joinTournamentAction(id: self.tournament!.id){ (res, error) in
                if res["message"] == "" {
                    self.showUpdatedStatusModal(parent: self.presentedViewController!, image: "team_work", info: "Félicitation !", message: "Vous allez participer au prochain tournoi ! Mais noubliez pas un match ne se gagne pas sur le terrain, mais lors de l'entrainement...", buttonTitle: "C'est noté !")
                } else {
                    self.showUpdatedStatusModal(parent: self.presentedViewController!, image: "presentation", info: "Oops !! Il semble qu'il y est eu un problème", buttonTitle: "Ok")
                }
            }
        case .Leave:
            TournamentService.leaveTournamentAction(id: self.tournament!.id){ (res, error) in
                print(res)
            }
        }
    }
    
    // Modals
    func showIssueModal() {
        let modal = TournamentActionModalViewController()
        modal.tournament = self.tournament!
        modal.delegate = self
        modal.showModal(parent: self)
    }
    
    func showUpdatedStatusModal(parent: UIViewController, image: String, info: String, message: String? = "", buttonTitle: String) {
        let modal = UpdatedStatusModalViewController()
        modal.initModal(parent: parent, image: image, info: info, message: message!, buttonTitle: buttonTitle)
        modal.showModal(parent: parent)
    }
    
    // Data
    func loadingTournament() {
        self.loader.startAnimating()
        self.mainView.isHidden = true
        self.statusView.isHidden = true
    }
    
    func noDisplayedTournament() {
        loader.stopAnimating()
        self.mainView.isHidden = true
        self.statusView.isHidden = false
        self.statusView.status(image: "presentation", info: "Vous n’avez aucun tournoi à avenir")
    }
    
    func displayTournament() {
        self.loader.stopAnimating()
        self.tournamentTableView.reloadData()
        self.mainView.isHidden = false
        self.statusView.isHidden = true
    }
}
