//
//  AuthService.swift
//  Corporate-Cup
//
//  Created by wesley on 17/05/2019.
//  Copyright © 2019 corporate-cup. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CallbackCheck = (_ res: JSON, _ error: Error?) -> Void
typealias CallbackAuth = (_ res: Any, _ error: Bool) -> Void


class AuthService {
    static func mailCheckAction(body: [String : Any], callBack: @escaping CallbackCheck) {
        let headers: HTTPHeaders = [
            "Content-type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        ]

        Alamofire.request(UrlBuilder.mailCheckUrl(), method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                callBack(json, nil)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func loginAction(body: [String : Any], callBack: @escaping CallbackAuth) {
        let headers: HTTPHeaders = [
            "Content-type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        Alamofire.request(UrlBuilder.loginUrl(), method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let id = json["user"]["id"].int ?? 0
                let companyId = json["user"]["company_id"].int ?? 0
                let name = json["user"]["name"].string ?? ""
                let email = json["user"]["email"].string ?? ""
                let registered = json["user"]["isRegistered"].bool ?? false
                let active = json["user"]["active"].bool ?? false
                let token = json["access_token"].string ?? ""
                
                let user = User.init(id: id, companyId: companyId, name: name, email: email, registered: registered, active: active, token: token)
                
                let code = (json["code"].int ?? 200)
                
                let error = code != UrlBuilder.sucessCode ? true : false
                
                callBack(user, error)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func finishRegisterAction(body: [String : Any], callBack: @escaping CallbackCheck) {
        let headers: HTTPHeaders = [
            "Content-type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        Alamofire.request(UrlBuilder.finishRegisterUrl(), method: .put, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                callBack(json, nil)
                
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func getHeadersAction() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Authorization": "Bearer " +  UserDefaults.getToken()!,
        ]
        
        return headers
    }
}
