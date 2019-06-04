//
//  Label.swift
//  Corporate-Cup
//
//  Created by wesley on 08/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

extension UILabel {
    func textStyle(text: String? = nil, color: UIColor? = UIColor.black, size: Int = 16, bold: Bool? = false, line: Int? = 1, center: Bool? = false, adaptive: Bool? = true, capitalizeFirstLetter: Bool? = true) {
        self.textColor = color
        self.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.numberOfLines = line!
        
        if text != nil {
            var text = String(text!)
            
            if capitalizeFirstLetter! {
                text.capitalizeFirstLetter()
            }
            
            self.text = text
        }
        
        self.font = UIFont.systemFont(ofSize: CGFloat(size), weight: .regular)
        
        if bold! {
            self.font = UIFont.systemFont(ofSize: CGFloat(size), weight: .bold)
        }
        
        if center! {
            self.textAlignment = .center
        }
        
        if adaptive! {
            return updateLabelFrame(label: self)
        }
    }
    
    var optimalHeight: CGFloat {
        get {
            let label = UILabel(frame:  CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
    }
    
    func setStatusLabel(status: MatchStatus, winner: Bool? = false){
        switch status {
        case .Finished:
            if winner! {
                self.textStyle(text: "Victoire", color: UIColor.FlatColor.green, size: 20, bold: true, center: true, adaptive: false)
            
            } else {
                self.textStyle(text: "Défaite", color: UIColor.FlatColor.pink, size: 20, bold: true, center: true, adaptive: false)
            
            }
            
        default:
            self.textStyle(text: "VS", color: UIColor.FlatColor.darkGrey, size: 18, bold: false, center: true, adaptive: false)
        }
        
    }
    
    func setScoreLabel(status: MatchStatus, winner: Bool){
        switch status {
        case .Finished:
            self.isHidden = false
            
            if winner {
                self.textStyle(text: "+3 pts", color: UIColor.FlatColor.green, size: 18, bold: true)
            
            } else {
                self.textStyle(text: "+1 pts", color: UIColor.FlatColor.pink, size: 18, bold: true)
            
            }
            
        default:
            self.isHidden = true
        }
    }
    
    func updateLabelFrame(label: UILabel) {
        let maxSize = CGSize(width: 150, height: 50)
        let size = label.sizeThatFits(maxSize)
        label.frame = CGRect(origin: CGPoint(x: label.frame.origin.x, y: label.frame.origin.y), size: size)
    }
}
