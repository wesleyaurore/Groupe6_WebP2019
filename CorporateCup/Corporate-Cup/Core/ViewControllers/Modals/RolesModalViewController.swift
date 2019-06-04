//
//  RolesModalViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 27/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class RolesModalViewController: UIViewController {
    // Properties
    let titleLabel = UILabel()
    let scrollView = UIScrollView()
    
    var delegate: LoginProfilDelegate? = nil
    
    let roles = ["Commercial", "Designer", "Developpeur"]
    
    let padding = CGFloat(20)
    let buttonHeight = CGFloat(55)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.FlatColor.darkBlue
        
        titleLabel.frame = CGRect(x: padding, y: padding * 4, width: self.view.frame.width - padding * 2, height: 50)
        titleLabel.textStyle(text: "Quel est votre poste ?", color: UIColor.white, size: 24, bold: true, line: 0, center: true, adaptive: false)
        self.view.addSubview(titleLabel)
        
        
        scrollView.frame = CGRect(x: padding, y: titleLabel.frame.maxY + padding * 2, width: view.frame.width - padding * 2, height: self.view.frame.height - padding * 4 - titleLabel.frame.maxY + padding * 2)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize.height = (padding + buttonHeight) * CGFloat(roles.count)
        self.view.addSubview(scrollView)
        
        for i in stride(from: roles.count - 1, to: -1, by: -1) {
            let roleButton = UIButton()
            roleButton.tag = i
            roleButton.frame = CGRect(x: 0, y: (buttonHeight + padding) * CGFloat(i), width: scrollView.frame.width, height: buttonHeight)
            roleButton.customButton(backgroundColor: UIColor(white: 0, alpha: 0), color: UIColor.white, cornerRadius: 3, borderColor: UIColor.white)
            roleButton.setTitle(roles[i], for: .normal)
            roleButton.addTarget(self, action:#selector(submit), for: .touchUpInside)
            
            scrollView.addSubview(roleButton)
        }   
    }
    
    @objc func submit(_ sender: UIButton){
        self.delegate?.assignRole(role: roles[sender.tag])
        dismiss(animated: true, completion: nil)
    }

}
