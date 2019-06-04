//
//  ContextualButtonView.swift
//  Corporate-Cup
//
//  Created by wesley on 03/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

extension UIView {
    func setStateButton(stateButton: UIButton, issueButton: UIButton, status: MatchStatus, congrat: Bool? = false) {
        self.backgroundColor = UIColor.FlatColor.lightGrey
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: 45)
        self.layer.zPosition = 999
        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5)
        
        func setButton(button: UIButton, tag: Int, text: String, color: UIColor){
            button.tag = tag
            button.setTitle(text, for: .normal)
            button.setTitleColor(color, for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            self.addSubview(button)
        }
        
        issueButton.isHidden = true
        
        if congrat! {
            setButton(button: stateButton, tag: 3, text: "Adversaire féliciter", color: UIColor.FlatColor.darkBlueTransparent)
        } else {
            switch status {
            case .Finished:
                setButton(button: stateButton, tag: 2, text: "Féliciter votre adversaire", color: UIColor.FlatColor.darkBlue)
        
            case .Running:
                setButton(button: stateButton, tag: 1, text: "Déclarer la fin du match", color: UIColor.FlatColor.darkBlue)
        
            default:
                //Start Button
                setButton(button: stateButton, tag: 0, text: "C'est Parti !", color: UIColor.FlatColor.darkBlue)
                stateButton.frame = CGRect(x: 0, y: 0, width: self.frame.width / 2, height: self.frame.size.height)
                
                // Help Button
                issueButton.isHidden = false
                
                setButton(button: issueButton, tag: -1, text: "Un Problème ?", color: UIColor.FlatColor.pink)
                issueButton.frame = CGRect(x: self.frame.width / 2, y: 0, width: self.frame.width / 2, height: self.frame.height)
                
                //Middle Border
                let middleBorder = CALayer()
                middleBorder.backgroundColor = UIColor.FlatColor.acideGrey.cgColor
                middleBorder.frame = CGRect(x: 0, y: 0, width: 0.5, height: issueButton.frame.size.height)
                issueButton.layer.addSublayer(middleBorder)
            }
        }
    }
}
