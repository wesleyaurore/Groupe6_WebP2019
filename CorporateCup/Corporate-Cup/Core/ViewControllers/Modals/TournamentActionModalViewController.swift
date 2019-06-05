//
//  TournamentActionModalViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 04/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class TournamentActionModalViewController: UIViewController {
    // Properties
    var delegate: TournamentDelegate? = nil
    var tournament: Tournament = Tournament()
    
    let contentView = UIView()
    let closeButton = UIButton()
    let contentTitle = UILabel()
    let contentInfo = UILabel()
    let borderLine = CALayer()
    let validateButton = UIButton()
    let denyButton = UIButton()
    let contentText = UILabel()
    
    
    let padding = CGFloat(20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.isOpaque = false
        
        // Content view
        contentView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
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
        contentTitle.text = tournament.name
        contentTitle.textStyle(color: UIColor.FlatColor.darkBlue, size: 18, bold: true)
        contentTitle.frame = CGRect(x: padding, y: closeButton.frame.maxY, width: contentTitle.frame.width, height: contentTitle.frame.height)
        contentView.addSubview(contentTitle)
        
        // Modal content
        contentInfo.frame = CGRect(x: padding, y: contentTitle.frame.maxY + padding / 2, width: closeButton.frame.minX, height: 0)
        contentView.addSubview(contentInfo)
        
        // Border line
        borderLine.backgroundColor = UIColor.FlatColor.acideGrey.cgColor
        borderLine.frame = CGRect(x: padding, y: contentInfo.frame.maxY + padding, width: contentView.frame.width - padding * 2, height: 1)
        contentView.layer.addSublayer(borderLine)
        
        // Content Text
        contentText.textStyle(text: "Un tournoi va commencer dans quelques jours. Inscrivez-vous et tentez de gagner une \(tournament.price)", size: 16, line: 0, adaptive: false)
        contentText.frame = CGRect(x: padding * 2, y: borderLine.frame.maxY + padding, width: self.view.frame.width - padding * 4, height: 0)
        let optimalHeight = contentText.optimalHeight
        
        contentText.frame = CGRect(x: contentText.frame.origin.x, y: contentText.frame.origin.y, width: contentText.frame.width, height: optimalHeight)
        contentText.numberOfLines = 0
        contentView.addSubview(contentText)
        
        // Postpone Button
        setStateButton(button: denyButton, anchor: contentText, label: "Plus tard", tag: 0, color: UIColor.FlatColor.pink)
        denyButton.frame = CGRect(x: denyButton.frame.origin.x, y: denyButton.frame.origin.y, width: denyButton.frame.width / 2 - padding / 4, height: denyButton.frame.height)
        
        // Join button
        setStateButton(button: validateButton, anchor: contentText, label: "Participer", tag: 1, color: UIColor.FlatColor.green)
        validateButton.frame = CGRect(x: denyButton.frame.maxX + padding / 2, y: validateButton.frame.origin.y, width: validateButton.frame.width / 2 - padding / 4, height: validateButton.frame.height)
    
        contentView.updateModalFrame(lastElement: validateButton, padding: padding)
    }
    
    func setStateButton(button: UIButton, anchor: AnyObject, label: String, tag: Int, color: UIColor, update: Bool? = false) {
        button.tag = tag
        button.setTitle(label, for: .normal)
        button.customButton(backgroundColor: color)
        button.frame = CGRect(x: padding, y: anchor.frame.maxY + padding, width: contentView.frame.width - padding * 2, height: button.frame.height)
        button.addTarget(self, action:#selector(handler), for: .touchUpInside)
        
        if !update! {
            contentView.addSubview(button)
        }
    }
    
    @objc func closeModal() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handler(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            dismiss(animated: true, completion: nil)
        case 1:
            self.delegate?.tournamentAction(action: .Join)
        case 2:
            self.delegate?.tournamentAction(action: .Leave)
        default:
            break
        }
    }

}
