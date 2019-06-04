//
//  TextField.swift
//  Corporate-Cup
//
//  Created by wesley on 25/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

extension UITextField {
    func pickerTextField(backgroundColor: UIColor? = UIColor.white, opacity: Float? = 0, borderColor: UIColor? = UIColor.white, cornerRadius: Float? = 5, color: UIColor? = UIColor.white,image: String? = nil, imageRect: CGRect? = nil, rightImage: String? = nil, rightImageRect: CGRect? = nil, padding: Int? = 10) {
        
        // General setting
        self.textColor = color
        self.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(opacity!))
        self.layer.cornerRadius = CGFloat(cornerRadius!)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColor?.cgColor
        
        // Left Icon settings
        if image != nil {
            let iconView = UIImageView(frame: (imageRect ?? nil)!)
            let iconSpacing = UIView(frame: (imageRect ?? nil)!)
            let icon = UIImage(named: image ?? "")
            
            iconSpacing.frame.size.width = iconView.frame.size.width + CGFloat(padding ?? 10)
            iconView.image = icon
            iconSpacing.addSubview(iconView)
            
            self.leftViewMode = UITextField.ViewMode.always
            self.leftView = iconSpacing
        }
        
        // Right Image settings
        if rightImage != nil {
            let iconView = UIImageView(frame: (rightImageRect ?? nil)!)
            let iconSpacing = UIView(frame: (rightImageRect ?? nil)!)
            let icon = UIImage(named: rightImage ?? "")
            
            iconSpacing.frame.size.width = iconView.frame.size.width + CGFloat(padding ?? 10)
            iconView.image = icon
            iconSpacing.addSubview(iconView)
            
            self.rightViewMode = UITextField.ViewMode.always
            self.rightView = iconSpacing
        }
    }
}
