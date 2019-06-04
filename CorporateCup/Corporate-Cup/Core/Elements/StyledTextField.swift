//
//  StyledTextField.swift
//  Corporate-Cup
//
//  Created by wesley on 19/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class StyledTextField: UITextField {
    // Properties
    let borderLine = CALayer()
    let validationView = UIView()
    let validationLabel = UILabel()
    let warningIconView = UIImageView()
    
    var color = UIColor()
    
    func setStyle(image: String? = nil, imageRect: CGRect? = nil, padding: Int? = 10, border: String? = nil, rightImage: String? = nil, rightImageRect: CGRect? = nil, color: UIColor? = UIColor.black, cornerRadius: Int? = nil) {
        
        // UI general setting
        self.color = color!
        self.textColor = color
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        
        // Set placeholder color
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: color!.withAlphaComponent(0.3)])
        
        // Border settings
        self.setBorder(border: border!, color: color!)
        
        
        // Left Icon settings
        if image != nil {
            self.setImage(image: image!, rect: imageRect!, padding: padding!)
        }
        
        // Right Image settings
        if rightImage != nil {
            self.setImage(image: rightImage!, rect: rightImageRect!, padding: padding!, right: true)
        }
    }
        
    func setBorder(border: String, color: UIColor){
        switch border {
        case "bottom":
            borderLine.name = "border-line"
            borderLine.frame = CGRect.init(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
            borderLine.backgroundColor = color.withAlphaComponent(0.3).cgColor
            
            self.borderStyle = UITextField.BorderStyle.none
            self.layer.addSublayer(borderLine)
            
        case "none":
            self.borderStyle = UITextField.BorderStyle.none
            
        default:
            self.layer.borderColor = color.withAlphaComponent(0.3).cgColor
        }
    }
    
    func changeBorderColor(color: UIColor) {
        if borderLine.name != nil {
            borderLine.backgroundColor = color.withAlphaComponent(0.3).cgColor
        }
        
        self.layer.borderColor = color.withAlphaComponent(0.3).cgColor
    }
    
    func setImage(image: String, rect: CGRect, padding: Int, right: Bool? = false) {
        let iconView = UIImageView(frame: rect)
        let iconSpacing = UIView(frame: rect)
        let icon = UIImage(named: image)
        
        iconSpacing.frame.size.width = iconView.frame.size.width + CGFloat(padding)
        iconView.image = icon
        iconSpacing.addSubview(iconView)
        
        if right! {
            self.rightViewMode = UITextField.ViewMode.always
            self.rightView = iconSpacing
        } else {
            self.leftViewMode = UITextField.ViewMode.always
            self.leftView = iconSpacing
        }
    }
    
    func validation(message: String){
        self.clearValidation()
        let padding = CGFloat(20)
        let iconSize = CGFloat(30)
      
        self.layer.zPosition = 999
        validationView.tag = 1
        
        warningIconView.image = UIImage(named: "warning_icon")
        
        validationView.backgroundColor = UIColor.white
        validationView.layer.cornerRadius = 3
        
        validationLabel.textStyle(color: UIColor.FlatColor.pink, size: 14, line: 0, adaptive: false)
        validationLabel.text = message
        
        // Set frames
        validationView.frame = CGRect(x: padding, y: self.frame.height + padding / 2, width: self.frame.width - padding * 2, height: 100)
        warningIconView.frame = CGRect(x: padding, y: 0, width: iconSize, height: iconSize)
        validationLabel.frame = CGRect(x: warningIconView.frame.maxX + padding / 2, y: padding / 2, width: validationView.frame.width - warningIconView.frame.maxX - padding * 2, height: 50)
    
        // Update frames
        let optimalHeight = validationLabel.optimalHeight
        
        warningIconView.frame = CGRect(x: warningIconView.frame.origin.x, y: optimalHeight / 2 - iconSize / 2 + padding / 2, width: warningIconView.frame.width, height: warningIconView.frame.height)
        validationLabel.frame = CGRect(x: validationLabel.frame.origin.x, y: validationLabel.frame.origin.y, width: validationLabel.frame.width, height: optimalHeight)
        validationView.frame = CGRect(x: validationView.frame.origin.x, y: validationView.frame.origin.y, width: validationView.frame.width, height: optimalHeight + padding)
        
        validationLabel.numberOfLines = 0
        
        validationView.addSubview(warningIconView)
        validationView.addSubview(validationLabel)
        self.addSubview(validationView)
    }
    
    func clearValidation() {
        if validationView.tag == 1 {
            self.layer.zPosition = 1
            validationView.removeFromSuperview()
            validationView.tag = 0
        }
    }
}
