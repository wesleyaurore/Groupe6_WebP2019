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
    @IBOutlet weak var rankingTableView: UITableView!
    
    let statusView = UIView()
    
    var ranking = ["Groupe A", "Groupe B", "Groupe C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rankingTableView.dataSource = self
        self.rankingTableView.delegate = self
        self.rankingTableView.isHidden = true
        
        self.view.addSubview(statusView)
        statusView.status(image: "presentation", info: "Il n’y a aucun palmarès en cours")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ranking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.rankingTableView.dequeueReusableCell(withIdentifier: "rankingCell", for: indexPath) as! GeneralRankingTableViewCell
        
        return cell
    }
}
