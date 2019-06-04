//
//  ModalViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 08/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class MatchResultModalViewController: UIViewController {
    // Properties
    var delegate: MatchListDelegate? = nil
    
    var match: Match?
    
    var select = false
    var win: Bool? = false
    var allowEquality: Bool? = false
    
    let contentView = UIView()
    let closeButton = UIButton()
    let contentTitle = UILabel()
    let contentText = UILabel()
    let borderLine = CALayer()
    let validateButton = UIButton()
    let equalityButton = UIButton()
    let denyButton = UIButton()
    
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
        contentTitle.text = "Resultat de la rencontre ?"
        contentTitle.textStyle(size: 18, bold: true)
        contentTitle.frame = CGRect(x: padding, y: closeButton.frame.maxY, width: contentTitle.frame.width, height: contentTitle.frame.height)
        contentView.addSubview(contentTitle)
        
        // Modal content
        contentText.frame = CGRect(x: padding, y: contentTitle.frame.maxY + padding / 2, width: closeButton.frame.minX, height: 0)
        contentView.addSubview(contentText)
        
        // Border line
        borderLine.backgroundColor = UIColor.FlatColor.acideGrey.cgColor
        borderLine.frame = CGRect(x: padding, y: contentText.frame.maxY + padding, width: contentView.frame.width - padding * 2, height: 1)
        contentView.layer.addSublayer(borderLine)
        
        // Win Button
        setStateButton(button: validateButton, anchor: borderLine, label: "J'ai gagné", tag: 1, color: UIColor.FlatColor.green)
        
        // Equality Button
        if allowEquality! {
            setStateButton(button: equalityButton, anchor: validateButton, label: "Égalité", tag: 10, color: UIColor.FlatColor.darkBlue)
        }
        
        // Lose Button
        let denyButtonAnchor = allowEquality! ? equalityButton : validateButton
        
        setStateButton(button: denyButton, anchor: denyButtonAnchor, label: "J'ai perdu", tag: 0, color: UIColor.FlatColor.pink)
        
        contentView.updateModalFrame(lastElement: denyButton, padding: padding)
    }
    
    // Init confirmation view
    func confirmationView() {
        let result = win! ? "gagné" : "perdu"
        
        // Modal content
        contentTitle.text = "Vous validez avoir \(result) ?"
        contentTitle.textStyle(size: 18, bold: true)
        
        contentText.text = "Une fois votre validation prise en compte, il sera impossible de changer le résultat."
        contentText.textStyle(size: 12, line: 2)
        contentText.frame = CGRect(x: padding, y: contentTitle.frame.maxY + padding / 2, width: closeButton.frame.minX, height: contentText.frame.height)
        contentView.addSubview(contentText)
        
        // Border line
        borderLine.frame = CGRect(x: padding, y: contentText.frame.maxY + padding, width: contentView.frame.width - padding * 2, height: 1)
        
        // Validation button
        setStateButton(button: validateButton, anchor: borderLine, label: "Oui", tag: 1, color: UIColor.FlatColor.green, update: true)
        
        // Equality button
        equalityButton.isHidden = true
        
        // Cancel Button
        setStateButton(button: denyButton, anchor: validateButton, label: "Non", tag: 1, color: UIColor.FlatColor.pink, update: true)
        
        // Update modal
        let modalHeight = denyButton.frame.maxY + padding
        
        contentView.frame = CGRect(x: contentView.frame.minX, y: self.view.frame.height - modalHeight, width: contentView.frame.width, height: modalHeight)
    }
    
    // Element func
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
    
    // Event handler
    @objc func handler(_ sender: UIButton) {
        if !select {
            if sender.tag == 1 {
                win = true
            }
            
            if sender.tag == 10 {
                win = nil
            }
            
            select = true
            
            confirmationView()
        } else {
            if sender.tag == 1 {
                self.delegate?.submitMatchResult(submit: true, win: win!)
            }
        }
    }
    
    @objc func closeModal() {
        dismiss(animated: true, completion: nil)
    }
}
