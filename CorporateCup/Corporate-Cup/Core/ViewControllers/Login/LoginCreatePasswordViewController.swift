//
//  LoginPasswordViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 25/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class LoginCreatePasswordViewController: UIViewController {
    @IBOutlet weak var passwordTextField: StyledTextField!
    @IBOutlet weak var confirmationTextField: StyledTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var email: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.setStyle(image: "key_icon", imageRect: CGRect(x: 0, y: 0, width: 20, height: 20), padding: 15, border: "bottom", color: UIColor.white)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        confirmationTextField.setStyle(image: "key_icon", imageRect: CGRect(x: 0, y: 0, width: 20, height: 20), padding: 15, border: "bottom", color: UIColor.white)
        confirmationTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        submitButton.customButton(backgroundColor: UIColor.FlatColor.green, color: UIColor.white)
    }
    
    @IBAction func validateAction(_ sender: Any) {
        let password = passwordTextField.text!
        let isValidPassword = checkPassword(password: password)
        
        if isValidPassword {
            if password == confirmationTextField.text {
                let loginProfilViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginProfilViewController") as! LoginProfilViewController
                
                loginProfilViewController.email = self.email
                loginProfilViewController.password = password
                
                self.present(loginProfilViewController, animated: true, completion: nil)
                return
            } else {
                confirmationTextField.validation(message: "Les mots de passe doivent être identiques")
            }
            
        } else if password.count == 0 {
            passwordTextField.validation(message: "Champs requis")
        
        } else {
            passwordTextField.validation(message: "Le mot de passe doit contenir au moins 8 caractères dont un chiffre et une lettre majuscule")
        }
    }
    
    private func checkPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[0-9])(?=.*[A-Z]).{8,}"
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    @objc func textFieldDidChange(_ sender: StyledTextField) {
        passwordTextField.clearValidation()
        confirmationTextField.clearValidation()
    }

}
