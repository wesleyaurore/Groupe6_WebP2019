//
//  JumpinViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 25/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class JumpinViewController: UIViewController {
    // Properties
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.customButton(backgroundColor: UIColor.FlatColor.green, color: UIColor.white)
    }

}
