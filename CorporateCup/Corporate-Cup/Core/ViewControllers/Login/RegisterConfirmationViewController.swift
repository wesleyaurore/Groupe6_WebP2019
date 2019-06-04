//
//  SigninConfirmationViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 25/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class RegisterConfirmationViewController: UIViewController {
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.customButton(backgroundColor: UIColor.FlatColor.green)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        let loginEmailViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginEmailViewController") as! LoginEmailViewController
        
        self.present(loginEmailViewController, animated: true, completion: nil)
    }
}
