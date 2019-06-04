//
//  ProblemModalViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 09/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class IssuesModalViewController: UIViewController {
    var delegate: MatchListDelegate? = nil
    var game: String? = nil
    
    let contentView = UIView()
    let closeButton = UIButton()
    let contentTitle = UILabel()
    let borderLine = CALayer()
    let cancelButton = UIButton()
    
    let padding = CGFloat(20)
    let pinSize = CGFloat(30)
    
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
        
        // Content title
        contentTitle.text = "Signaler un problème"
        contentTitle.textStyle(color: UIColor.black, size: 18, bold: true)
        contentTitle.frame = CGRect(x: padding, y: closeButton.frame.maxY, width: contentTitle.frame.width, height: contentTitle.frame.height)
        contentView.addSubview(contentTitle)
        
        // Border line
        borderLine.backgroundColor = UIColor.FlatColor.acideGrey.cgColor
        borderLine.frame = CGRect(x: padding, y: contentTitle.frame.maxY + padding, width: contentView.frame.width - padding * 2, height: 1)
        contentView.layer.addSublayer(borderLine)
        
        // Button issue 0
        let buttonIssue0 = UIButton()
        setButton(button: buttonIssue0, anchor: borderLine, label: "Mon adversaire n'est pas disponible", tag: 0, color: UIColor.FlatColor.pink)
        
        // Button issue 1
        let buttonIssue1 = UIButton()
        setButton(button: buttonIssue1, anchor: buttonIssue0, label: "Abandon", tag: 1, color: UIColor.FlatColor.pink)

        // Button issue 1
        let buttonIssue2 = UIButton()
        setButton(button: buttonIssue2, anchor: buttonIssue1, label: "Matériel non disponible", tag: 2, color: UIColor.FlatColor.pink)
        
        // Cancel Button
        setButton(button: cancelButton, anchor: buttonIssue2, label: "Annuler", tag: -1, color: UIColor.FlatColor.green)
        cancelButton.removeTarget(self, action:#selector(handler), for: .touchUpInside)
        cancelButton.addTarget(self, action:#selector(closeModal), for: .touchUpInside)
        
        // Update modal frame
        contentView.updateModalFrame(lastElement: cancelButton, padding: padding)
    }
    
    func setButton(button: UIButton, anchor: AnyObject, label: String, tag: Int, color: UIColor) {
        button.tag = tag
        button.setTitle(label, for: .normal)
        button.customButton(backgroundColor: color)
        button.frame = CGRect(x: padding, y: anchor.frame.maxY + padding, width: contentView.frame.width - padding * 2, height: button.frame.height)
        button.addTarget(self, action:#selector(handler), for: .touchUpInside)
        contentView.addSubview(button)
    }
    
    @objc func handler(_ sender: UIButton) {
        self.delegate?.submitIssue(issueCode: sender.tag)
    }
    
    @objc func closeModal() {
        dismiss(animated: true, completion: nil)
    }
}
