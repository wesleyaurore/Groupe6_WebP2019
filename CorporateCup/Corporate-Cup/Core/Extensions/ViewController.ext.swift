//
//  ViewController.swift
//  Corporate-Cup
//
//  Created by wesley on 09/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

extension UIViewController {
    var basicLoader: UIActivityIndicatorView {
        get {
            let loader = UIActivityIndicatorView()
            loader.center = self.view.center
            loader.hidesWhenStopped = true
            loader.style = .gray
            self.view.addSubview(loader)
            
            return loader
        }
    }
    
    func showModal(parent: AnyObject) {
        self.modalPresentationStyle = .overCurrentContext
        parent.present(self, animated: true, completion: nil)
    }
}
