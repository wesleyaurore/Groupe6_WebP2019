//
//  MatchStartModalViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 09/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class MatchStartModalViewController: UIViewController, MatchStartModalDelegate {
    // Properties
    var delegate: MatchListDelegate? = nil
    var match: Match? = nil
    
    let contentView = UIView()
    let closeButton = UIButton()
    let contentTitle = UILabel()
    let contentText = UILabel()
    let pin = UIButton()
    let stateLabel = UILabel()
    let scoreLabel = UILabel()
    let borderLine = CALayer()
    let scrollView = UIScrollView()
    let validateButton = UIButton()
    
    let padding = CGFloat(20)
    let pinSize = CGFloat(30)
    
    let states = ["win", "null", "lose"]
    
    // Data provider
    func provideRules(match: Match) {
        self.match = match
        contentTitle.text = match.activity.name
        contentText.text = match.activity.rules
        
        let optimalHeight = contentText.optimalHeight
        
        contentText.frame = CGRect(x: contentText.frame.origin.x, y: contentText.frame.origin.y, width: contentText.frame.width, height: optimalHeight)
        contentText.numberOfLines = 0
    }
    
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
        contentTitle.textStyle(color: UIColor.FlatColor.darkBlue, size: 18, bold: true)
        contentTitle.frame = CGRect(x: padding, y: closeButton.frame.maxY, width: contentTitle.frame.width, height: contentTitle.frame.height)
        contentView.addSubview(contentTitle)
        
        // Content text
        contentText.textStyle(size: 14, line: 2, adaptive: false)
        contentText.frame = CGRect(x: padding, y: contentTitle.frame.maxY + padding / 2, width: closeButton.frame.minX, height: contentText.frame.height)
        contentView.addSubview(contentText)
        
        // Rule Pin
        for i in stride(from: states.count - 1, to: -1, by: -1) {
            let image = "\(states[i])_icon"
            
            let pinSection = contentView.frame.width / CGFloat(states.count)
            let currentSection = pinSection * CGFloat(i)
            
            pin.frame = CGRect(x: currentSection + pinSection / 2 - pinSize / 2, y: contentText.frame.maxY + padding, width: pin.frame.width, height: pin.frame.height)
            
            if states[i] == "win" {
                rulePin(image: image, color: UIColor.FlatColor.green, state: "Victoire", score: "+3pts", iconPadding: 7)
            }
            
            if states[i] == "null" {
                rulePin(image: image, color: UIColor.FlatColor.darkBlue, state: "Nul", score: "+2pts", iconPadding: 8)
            }
            
            if states[i] == "lose" {
                rulePin(image: image, color: UIColor.FlatColor.pink, state: "Defaite", score: "+1pts", iconPadding: 9)
            }
        }
        
        // Border line
        borderLine.backgroundColor = UIColor.FlatColor.acideGrey.cgColor
        borderLine.frame = CGRect(x: padding, y: scoreLabel.frame.maxY + padding, width: contentView.frame.width - padding * 2, height: 1)
        contentView.layer.addSublayer(borderLine)
        
        // Validate button
        validateButton.tag = 1
        validateButton.setTitle("Jouer", for: .normal)
        validateButton.customButton(backgroundColor: UIColor.FlatColor.green)
        validateButton.frame = CGRect(x: padding, y: borderLine.frame.maxY + padding, width: contentView.frame.width - padding * 2, height: validateButton.frame.height)
        validateButton.addTarget(self, action:#selector(submit), for: .touchUpInside)
        contentView.addSubview(validateButton)
        
        contentView.updateModalFrame(lastElement: validateButton, padding: padding)
    }
    
    func rulePin(image: String, color: UIColor, state: String, score: String, iconPadding: CGFloat) {
        let pin = UIButton()
        let stateLabel = UILabel()
        let scoreLabel = UILabel()
        
        let fontSize = 16
        let labelPadding = CGFloat(3)
        
        // Button
        pin.frame = self.pin.frame
        pin.pinStyle(image: image, size: pinSize, backgroundColor: color, padding: iconPadding)
        contentView.addSubview(pin)
        // State label
        stateLabel.text = state
        stateLabel.textStyle(color: color, size: fontSize, bold: true)
        stateLabel.frame = CGRect(x: pin.frame.minX + pin.frame.width / 2 - stateLabel.frame.width / 2, y: pin.frame.maxY + labelPadding, width: stateLabel.frame.width, height: stateLabel.frame.height)
        contentView.addSubview(stateLabel)
        
        self.stateLabel.frame = stateLabel.frame
        
        // Score
        scoreLabel.text = score
        scoreLabel.textStyle(color: color, size: fontSize, bold: true)
        scoreLabel.frame = CGRect(x: pin.frame.minX + pin.frame.width / 2 - scoreLabel.frame.width / 2, y: stateLabel.frame.maxY + labelPadding, width: scoreLabel.frame.width, height: scoreLabel.frame.height)
        contentView.addSubview(scoreLabel)
        
        self.scoreLabel.frame = scoreLabel.frame
    }
    
    @objc func submit() {
        self.delegate?.startMatch()
    }
    
    @objc func closeModal() {
        dismiss(animated: true, completion: nil)
    }
}
