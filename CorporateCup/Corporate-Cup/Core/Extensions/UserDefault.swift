//
//  UserDefault.swift
//  Corporate-Cup
//
//  Created by wesley on 19/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import Foundation

extension UserDefaults {
    static func saveThisUser(user: User) {
        
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(data, forKey: "cc_user")
        
    }
    
    static func getTheUserStored() -> User? {
        let userData = UserDefaults.standard.data(forKey: "cc_user")
        
        if (userData == nil) {
            return nil
        }
        else {
            let userFound:User? = NSKeyedUnarchiver.unarchiveObject(with: userData!) as? User
            return userFound
        }
    }
    
    
    static func getToken() -> String? {
        let userData = UserDefaults.standard.data(forKey: "cc_user")
        if (userData == nil) {
            return nil
        }
        else {
            let userFound:User? = NSKeyedUnarchiver.unarchiveObject(with: userData!) as? User
            let token = userFound!.token

            return token
        }
    }
    
//
//    static func getCompanyId() -> Int? {
//        let userData = UserDefaults.standard.data(forKey: "clunch_user")
//        if (userData == nil) {
//            return nil
//        }
//        else {
//            let userFound:User? = NSKeyedUnarchiver.unarchiveObject(with: userData!) as? User
////            let companyId = userFound!.companyId
//
////            return companyId
//        }
//    }
}

