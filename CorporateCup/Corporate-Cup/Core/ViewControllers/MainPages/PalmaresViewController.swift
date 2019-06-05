//
//  PalmaresViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 30/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class PalmaresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Properties
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var palmaresTitle: UILabel!
    @IBOutlet weak var palmaresTableView: UITableView!
    
    var loader: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let statusView = UIView()
    
    var players: [Player]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "Palmarès"
        
        self.view.backgroundColor = UIColor.FlatColor.lightGrey
        self.mainView.backgroundColor = UIColor.FlatColor.lightGrey
        self.palmaresTableView.backgroundColor = UIColor.FlatColor.lightGrey
        
        self.palmaresTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.palmaresTableView.allowsSelection = false
        
        self.palmaresTableView.dataSource = self
        self.palmaresTableView.delegate = self
        
        self.mainView.isHidden = true
        
        self.view.addSubview(statusView)
        loader = basicLoader
        
        loadingPalmares()
        loadPalmares()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if players != nil {
            return players!.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.palmaresTableView.dequeueReusableCell(withIdentifier: "palmaresRankCell", for: indexPath) as! PalmaresRankTableViewCell
        
        if players != nil {
            let sortedPlayers = players!.sorted(by: { $0.score > $1.score })
            cell.initializeRank(player: sortedPlayers[indexPath.row], rank: indexPath.row + 1)
            
        }
        
        return cell
    }
    
    // Data
    private func loadPalmares() {
        loadingPalmares()
        
        PalmaresService.palmaresAction(){ (res, error) in
            if error {
                self.statusView.isHidden = false
                self.statusView.status(image: "presentation", info: "Oops !! Une erreur est subvenue.")
            } else {
                let players = (res as! [Player])
                
                if players.count == 0 {
                    self.noDisplayedPalmares()
                    self.statusView.status(image: "presentation", info: "Il n’y a aucun palmarès à afficher")
                } else {
                    self.players = players
                    self.displayPalmares()
                }
            }
        }
    }
    
    func loadingPalmares() {
        self.loader.startAnimating()
        self.mainView.isHidden = true
        self.statusView.isHidden = true
    }
    
    func noDisplayedPalmares() {
        loader.stopAnimating()
        self.mainView.isHidden = true
        self.statusView.isHidden = false
    }
    
    func displayPalmares() {
        loader.stopAnimating()
        self.statusView.isHidden = true
        self.mainView.isHidden = false
        self.palmaresTableView.reloadData()
    }
}
