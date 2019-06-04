//
//  Button.swift
//  Corporate-Cup
//
//  Created by wesley on 25/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

extension UIButton {
    func customButton(width: Int? = nil, height: Int? = nil, backgroundColor: UIColor? = UIColor.black, color: UIColor? = UIColor.white, cornerRadius: CGFloat? = nil, borderColor: UIColor? = nil, image: String? = nil, iconWidth: Int? = 30, iconPadding: Int? = 100, fontSize: CGFloat? = 18){
        
        // Button Size
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: CGFloat(width ?? Int(self.frame.size.width)), height: CGFloat(height ?? 50))
        
        //UI general settings
        self.backgroundColor = backgroundColor
        
        self.tintColor = color
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor != nil ? borderColor?.cgColor : backgroundColor?.cgColor
        self.layer.cornerRadius = cornerRadius ?? self.frame.height / 2
        
        // Icon settings
        if image != nil {
            let icon = UIImage(named: image ?? "")!
            
            self.setImage(icon, for: .normal)
            self.imageView?.contentMode = .scaleAspectFit
            
            // Title size
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat(-iconWidth! * 2), bottom: 0, right: 0)
            
            // Icon size
            self.imageEdgeInsets = UIEdgeInsets(top: self.frame.height / 4, left: 0, bottom: self.frame.height / 4, right: self.frame.width - CGFloat(iconWidth!) - CGFloat(iconPadding!))
        }
    }
    
    func closeButton() {
        let cross = UIImage(named: "cross")
        self.setImage(cross, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: self.frame.height, left: self.frame.width, bottom: self.frame.height, right: self.frame.width)
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func pinStyle(image: String, size: CGFloat? = 50, backgroundColor: UIColor? = UIColor.FlatColor.darkBlue, padding: CGFloat? = 10) {
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: size!, height: size!)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = size! / 2
        let iconSize = size! - padding!
        
        let icon = UIImage(named: image)
        self.setImage(icon, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: iconSize, left: iconSize, bottom: iconSize, right: iconSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func disabled() {
        self.isEnabled = false
        self.alpha = 0.5
    }
    
    func enabled(){
        self.isEnabled = true
        self.alpha = 1
    }
}
