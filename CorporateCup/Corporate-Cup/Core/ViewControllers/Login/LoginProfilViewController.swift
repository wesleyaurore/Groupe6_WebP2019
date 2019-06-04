//
//  LoginProfilViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 25/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

extension LoginProfilViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = image
        }
        
        picker.dismiss(animated: true)
    }
}

protocol LoginProfilDelegate {
    func assignRole(role: String)
}

class LoginProfilViewController: UIViewController, LoginProfilDelegate {
    // Properties
    @IBOutlet weak var nameTextField: StyledTextField!
    @IBOutlet weak var roleTextField: StyledTextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imagePickerButton: UIButton!
    
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Image picker
        imageView.circleImage()
        
        // Name text field
        nameTextField.setStyle(image: "profil_icon", imageRect: CGRect(x: 0, y: 0, width: 25, height: 25), padding: 15, border: "bottom", color: UIColor.white)
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        // Role picker Text field
        roleTextField.pickerTextField(backgroundColor: UIColor.FlatColor.darkBlue, image: "wand_icon", imageRect: CGRect(x: 20 , y: -2, width: 25, height: 25),rightImage: "arrow_right_icon", rightImageRect: CGRect(x: 0, y: 0, width: 13, height: 20), padding: 30)
        roleTextField.addTarget(self, action:#selector(roleTouchHandler), for: .touchDown)
        
        // Submit button
        submitButton.customButton(backgroundColor: UIColor.FlatColor.green, color: UIColor.white)
    }
    
    func assignRole(role: String) {
        roleTextField.text = role
    }
    
    // Actions
    @IBAction func imagePickerAction(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true) {}
    }
    
    @objc func textFieldDidChange(_ sender: StyledTextField) {
        sender.clearValidation()
    }
    
    @objc func roleTouchHandler(_ sender: StyledTextField) {
        sender.clearValidation()
        
        let modal = RolesModalViewController()
        modal.delegate = self
        modal.showModal(parent: self)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        let isValidName = checkName(name: nameTextField.text ?? "")
        
        let params: [String : Any] = [
            "email": self.email!,
            "password": self.password!,
            "password_confirmation": self.password!,
            "name": self.nameTextField.text!
        ]
        
        if isValidName {
            if roleTextField.text == "Role" {
                roleTextField.validation(message: "Champs requis")
            } else {
                AuthService.finishRegisterAction(body: params){ (res, error) in
                    let message = res["message"].string
                    
                    if message == "Successfully updated user, check your email to activate your account" {
                        let registerConfirmationViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterConfirmationViewController") as! RegisterConfirmationViewController
                        
                        self.present(registerConfirmationViewController, animated: true, completion: nil)
                        
                    } else {
                        self.nameTextField.validation(message: "Une erreur est survenue")
                    }
                }
            }
        } else if nameTextField.text!.count == 0 {
            nameTextField.validation(message: "Champs requis")
            
        } else {
            nameTextField.validation(message: "Votre nom doit contenir entre 3 et 15 caractères et ne doit pas contenir de caratères speciaux")
        }
    }
    
    private func checkName(name: String) -> Bool {
        let nameRegEx = "^[A-Za-z0-9]{3,15}$"
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: name)
    }
}



//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Name text field
//    nameTextField.setStyle(image: "profil_icon", imageRect: CGRect(x: 0, y: 0, width: 25, height: 25), padding: 15, border: "bottom", color: UIColor.white)
//
//    // Picker Text field
//    let pickerView = UIPickerView()
//    pickerView.delegate = self
//    roleTextField.inputView = pickerView
//    roleTextField.text = roles[0]
//
//    roleTextField.pickerTextField(backgroundColor: UIColor.FlatColor.darkBlue, image: "wand_icon", imageRect: CGRect(x: 20 , y: -2, width: 25, height: 25),rightImage: "arrow_right_icon", rightImageRect: CGRect(x: 0, y: 0, width: 13, height: 20), padding: 30)
//
//    // Submit button
//    submitButton.customButton(backgroundColor: UIColor.FlatColor.green, color: UIColor.white)
//}

//    //PickerTextField
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return roles.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return roles[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        roleTextField.text = roles[row]
//    }
//
