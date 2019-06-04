//
//  CongratModalViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 08/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class CongratModalViewController: UIViewController {
    // Properties
    var delegate: MatchListDelegate? = nil
    
    let contentView = UIView()
    let closeButton = UIButton()
    let contentTitle = UILabel()
    let borderLine = CALayer()
    let scrollView = UIScrollView()
    let validateButton = UIButton()
    
    var selectedBadge = UIButton()
    
    let padding = CGFloat(20)
    let badgeSize = CGFloat(110)
    let badgeLabelSize = CGFloat(14)
    
    var badges: [Badge] = [Badge]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.isOpaque = false
        
        // Fetch pins
        MatchService.getBadgesAction(){ (res, error) in
            self.badges = (res as! [Badge])
            
            self.showBadges()
        }
        
        // Content view
        contentView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height)
        contentView.backgroundColor = UIColor.white
        contentView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        view.addSubview(contentView)
        
        if let navigationController = self.presentingViewController?.navigationController {
            contentView.frame = CGRect(x: contentView.frame.minX, y: navigationController.navigationBar.frame.maxY, width: contentView.frame.width, height: contentView.frame.height - navigationController.navigationBar.frame.maxY)
        }
        
        // Close button
        let buttonSize = CGFloat(20)
        
        closeButton.frame = CGRect(x: contentView.frame.width - padding * 2, y: padding, width: buttonSize, height: buttonSize)
        closeButton.closeButton()
        closeButton.addTarget(self, action:#selector(closeModal), for: .touchUpInside)
        contentView.addSubview(closeButton)
        
        // Modal title
        contentTitle.text = "Complimenter votre adversaire"
        contentTitle.textStyle(size: 18, bold: true)
        contentTitle.frame = CGRect(x: padding, y: closeButton.frame.maxY, width: contentTitle.frame.width, height: contentTitle.frame.height)
        contentView.addSubview(contentTitle)
        
        // Border line
        borderLine.backgroundColor = UIColor.FlatColor.acideGrey.cgColor
        borderLine.frame = CGRect(x: padding, y: contentTitle.frame.maxY + padding, width: contentView.frame.width - padding * 2, height: 1)
        contentView.layer.addSublayer(borderLine)
        
        // Scrollable view
        scrollView.frame = CGRect(x: 0, y: borderLine.frame.maxY, width: view.frame.width, height: badgeSize + badgeLabelSize + padding * 2)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scrollView)
        
        // Validation Button
        validateButton.tag = 1
        validateButton.disabled()
        validateButton.setTitle("Complimenter", for: .normal)
        validateButton.customButton(backgroundColor: UIColor.FlatColor.green)
        validateButton.frame = CGRect(x: padding, y: scrollView.frame.maxY + padding / 2, width: contentView.frame.width - padding * 2, height: validateButton.frame.height)
        validateButton.addTarget(self, action:#selector(submit), for: .touchUpInside)
        contentView.addSubview(validateButton)
        
        contentView.updateModalFrame(lastElement: validateButton, padding: padding)
    }
    
    func showBadges() {
        // Pins
        for i in stride(from: badges.count - 1, to: -1, by: -1) {
            // Pin
            let badge = UIButton()
            badge.tag = badges[i].id
            badge.pinStyle(image: badges[i].image, size: badgeSize, padding: padding)
            badge.frame = CGRect(x: padding + (padding + badgeSize) * CGFloat(i), y: scrollView.frame.minX + scrollView.frame.height / 2 - badge.frame.height / 2 - badgeLabelSize, width: badge.frame.width, height: badge.frame.height)
            badge.addTarget(self, action:#selector(handler), for: .touchUpInside)
            scrollView.addSubview(badge)
            
            // Pin label
            let badgeLabel = UILabel()
            badgeLabel.text = badges[i].title
            badgeLabel.frame = CGRect(x: padding + (padding + badgeSize) * CGFloat(i) + badgeSize / 2 - (badgeSize + padding * 2) / 2, y: badge.frame.maxY + padding / 2, width: badgeSize + padding * 2, height: 20)
            badgeLabel.textStyle(size: 14, center: true, adaptive: false)
            scrollView.addSubview(badgeLabel)
        }
        
        scrollView.contentSize.width = padding + (padding + badgeSize) * CGFloat(badges.count)
    }
    
    @objc func handler(_ sender: UIButton) {
        if sender != selectedBadge {
            sender.backgroundColor = UIColor.FlatColor.green
            
            selectedBadge.backgroundColor = UIColor.FlatColor.darkBlue
            selectedBadge = sender
            
            validateButton.enabled()
        } else {
            sender.backgroundColor = UIColor.FlatColor.darkBlue
            
            selectedBadge = UIButton()
            
            validateButton.disabled()
        }
    }
    
    @objc func submit(_ sender: UIButton) {
        delegate?.submitCongrat(badge: selectedBadge.tag)
//        showUpdatedStatusModal(image: "team_work", info: "Résultat envoyé !", message: "Vous ferez mieux la prochaine fois :)", buttonTitle: "Ok")
    }
    
    @objc func closeModal() {
        dismiss(animated: true, completion: nil)
    }
}
