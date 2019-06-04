//
//  LoginEmailViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 25/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginEmailViewController: UIViewController {
    // Properties
    @IBOutlet weak var emailTextField: StyledTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let validationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.setStyle(image: "email_icon", imageRect: CGRect(x: 0, y: 0, width: 25, height: 18), padding: 15, border: "bottom", color: UIColor.white)
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        submitButton.customButton(backgroundColor: UIColor.FlatColor.green, color: UIColor.white)
    }
    
    @IBAction func submitMailAction(_ sender: Any) {
        let email = emailTextField.text!
        let isValidEmail = checkEmail(email: email)
        
        if isValidEmail {
            let params: [String: Any] = [
                "email": email
            ]
            
            AuthService.mailCheckAction(body: params){ (res, error) in
                if res["user"] != false {
                    let user = res["user"]
                    if user["active"].bool! {
                        let loginPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginPasswordViewController") as! LoginPasswordViewController
    
                        loginPasswordViewController.email = email
    
                        self.present(loginPasswordViewController, animated: true, completion: nil)
    
                    } else if user["isRegistered"].bool! {
                        let loginCreatePasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginCreatePasswordViewController") as! LoginCreatePasswordViewController
    
                        loginCreatePasswordViewController.email = email
    
                        self.present(loginCreatePasswordViewController, animated: true, completion: nil)
                    } else {
                        self.emailTextField.validation(message: "Adresse e-mail invalide")
                    }
                } else {
                    self.emailTextField.validation(message: res["message"].string!)
                }
            }
            
        } else if email.count == 0 {
            emailTextField.validation(message: "Champs requis")
        } else {
            emailTextField.validation(message: "Adresse e-mail invalide")
        }
    }
    
    private func checkEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    @objc func textFieldDidChange(_ sender: StyledTextField) {
        sender.clearValidation()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
