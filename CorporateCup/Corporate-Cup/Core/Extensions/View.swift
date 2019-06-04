//
//  View.swift
//  Corporate-Cup
//
//  Created by wesley on 08/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

extension UIView {
    func player(player: Player, width: CGFloat? = 70, height: CGFloat? = 70, textPadding: CGFloat? = 10) {
        let imageView = player.avatar
        imageView.frame = CGRect(x: 0, y: 0, width: width!, height: height!)
        imageView.contentMode = .scaleAspectFit
        imageView.circleImage()
        self.addSubview(imageView)
        
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: self.frame.width / 2 - self.frame.width / 2, y: height! + textPadding!, width: self.frame.width, height: 20)
        textLayer.string = player.name
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.fontSize = 14.0
        textLayer.font = UIFont.systemFont(ofSize: 10.0)
        textLayer.foregroundColor = UIColor.black.cgColor
        
        self.layer.addSublayer(textLayer)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addShadow(){
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.cornerRadius = 5
        
        let ghostCard = UIView()
        ghostCard.layer.backgroundColor = UIColor.white.cgColor
        ghostCard.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        ghostCard.layer.cornerRadius = 5
        ghostCard.layer.masksToBounds = false
        self.sendSubviewToBack(ghostCard)
    }
    
    func updateModalFrame(lastElement: AnyObject, padding: CGFloat) {
        let modalHeight = lastElement.frame.maxY + padding
        
        self.frame = CGRect(x: self.frame.minX, y: self.frame.height - modalHeight, width: self.frame.width, height: modalHeight)
    }
    
    func status(image: String, info: String, message: String? = "", button: UIButton? = nil, buttonTitle: String? = "", color: UIColor? = UIColor.FlatColor.darkBlue) {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        
        let padding = CGFloat(20)
        
        // Set image
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
        imageView.frame = CGRect(x: padding, y: padding * 4, width: self.frame.width - padding * 2, height: 160)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        // Set info label
        let infoLabel = UILabel()
        infoLabel.frame = CGRect(x: padding * 2, y: imageView.frame.maxY + padding * 2, width: self.frame.width - padding * 4, height: 50)
        infoLabel.textStyle(text: info, color: color, size: 24, bold: true, line: 0, center: true, adaptive: false)

        let infoOptimalHeight = infoLabel.optimalHeight

        infoLabel.frame = CGRect(x: infoLabel.frame.origin.x, y: infoLabel.frame.origin.y, width: infoLabel.frame.width, height: infoOptimalHeight)
        infoLabel.numberOfLines = 0
        self.addSubview(infoLabel)
        
        // Set message label
        let messageLabel = UILabel()
        messageLabel.frame = CGRect(x: padding * 3, y: infoLabel.frame.maxY + padding, width: self.frame.width - padding * 6, height: 0)
        
        if message != "" {
            messageLabel.textStyle(text: message, color: color, size: 14, line: 0, center: true, adaptive: false)
            
            let messageOptimalHeight = messageLabel.optimalHeight
            
            messageLabel.frame = CGRect(x: messageLabel.frame.origin.x, y: messageLabel.frame.origin.y, width: messageLabel.frame.width, height: messageOptimalHeight)
            messageLabel.numberOfLines = 0
            self.addSubview(messageLabel)
        }
        
        // Set button
        if button != nil {
            button?.setTitle(buttonTitle, for: .normal)
            button?.customButton(backgroundColor: UIColor.FlatColor.green, fontSize: 16)
            button?.frame = CGRect(x: padding, y: messageLabel.frame.maxY + padding * 3, width: self.frame.width - padding * 2, height: button!.frame.height)
            self.addSubview(button!)
        }
    }
}
