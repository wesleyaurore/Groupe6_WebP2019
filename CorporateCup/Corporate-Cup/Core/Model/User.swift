//
//  User.swift
//  Corporate-Cup
//
//  Created by wesley on 19/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    // Properties
    let id: Int
    let companyId: Int
    let name: String
    let email: String
    let registered: Bool
    let active: Bool
    let token: String
    
    // Initialization
    init(id: Int = 0, companyId: Int = 0, name: String = "", email: String = "", registered: Bool = false, active: Bool = false, token: String = "") {
        self.id = id
        self.companyId = companyId
        self.name = name
        self.email = email
        self.registered = registered
        self.active = active
        self.token = token
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey : "id")
        aCoder.encode(companyId, forKey : "companyId")
        aCoder.encode(name, forKey : "name")
        aCoder.encode(email, forKey : "email")
        aCoder.encode(active, forKey : "active")
        aCoder.encode(registered, forKey : "registered")
        aCoder.encode(token, forKey : "token")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.companyId = aDecoder.decodeInteger(forKey: "companyId")
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.registered = (aDecoder.decodeObject(forKey: "registered") != nil)
        self.active = (aDecoder.decodeObject(forKey: "active") != nil)
        self.token = aDecoder.decodeObject(forKey: "token") as! String
    }
}
