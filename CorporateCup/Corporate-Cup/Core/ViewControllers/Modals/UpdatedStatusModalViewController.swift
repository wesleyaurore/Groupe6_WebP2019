//
//  UpdatedStatusModalViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 03/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

class UpdatedStatusModalViewController: UIViewController {
    // Properties
    var modalParent: AnyObject? = nil
    let statusView = UIView()
    let image = UIImage()
    let pageTitle = UILabel()
    let message = UILabel()
    let statusButton = UIButton()
    
    
    func initModal(parent: AnyObject, image: String, info: String, message: String, buttonTitle: String){
        self.modalParent = parent
        
        self.view.addSubview(statusView)
        statusView.status(image: image, info: info, message: message, button: statusButton, buttonTitle: buttonTitle, color: UIColor.white)
        
        statusButton.addTarget(self, action:#selector(statusButtonHandler), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.view.backgroundColor = UIColor.FlatColor.darkBlue
    }
    
    @objc func statusButtonHandler() {
        modalParent?.view.isHidden = true
        dismiss(animated: true, completion: nil)
        modalParent?.dismiss(animated: false, completion: nil)
        
    }
}
