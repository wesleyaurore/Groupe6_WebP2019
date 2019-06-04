//
//  CapitalizingFirstLetter.swift
//  Corporate-Cup
//
//  Created by wesley on 10/04/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
