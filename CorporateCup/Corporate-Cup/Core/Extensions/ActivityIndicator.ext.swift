//
//  ActivityIndicator.swift
//  Corporate-Cup
//
//  Created by wesley on 04/06/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    func loading() {
        self.center = self.view.center
        self.hidesWhenStopped = true
        self.style = .gray
    }
    
    func stop() {
        self.stopAnimating = true
    }
}
