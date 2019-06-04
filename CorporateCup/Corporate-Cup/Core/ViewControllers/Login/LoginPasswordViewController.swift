//
//  LoginPasswordViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 26/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class LoginPasswordViewController: UIViewController {
    // Properties
    @IBOutlet weak var passwordTextField: StyledTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.setStyle(image: "key_icon", imageRect: CGRect(x: 0, y: 0, width: 20, height: 20), padding: 15, border: "bottom", color: UIColor.white)
        
        submitButton.customButton(backgroundColor: UIColor.FlatColor.green)
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @IBAction func submitPassword(_ sender: Any) {
        let params: [String: Any] = [
            "email":email,
            "password":passwordTextField.text!
        ]
        
        if passwordTextField.text != "" {
            AuthService.loginAction(body: params){ (res, error) in
                if error {
                    self.passwordTextField.validation(message: "Mot de passe incorrect")
                } else {
                    let user = res as! User
                    if user.active {
                        UserDefaults.saveThisUser(user: user)
                        
                        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
                        self.present(mainNavigationController, animated: true, completion: nil)
                    } else if user.registered {
                        self.passwordTextField.validation(message: "Vous devez valider votre e-mail")
                    } else {
                        self.passwordTextField.validation(message: "Mot de passe incorect")
                    }
                }
            }
        } else {
            passwordTextField.validation(message: "Champs requis")
        }
    }
    
    @objc func textFieldDidChange() {
        passwordTextField.clearValidation()
    }
}
