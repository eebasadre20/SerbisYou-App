//
//  LoginManager.swift
//  SerbisYou-App
//
//  Created by Edsil Basadre on 17/02/2017.
//  Copyright © 2017 eebasadre.co. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class LoginManager: AuthManager {
   let createToken: String = "/api/oauth/token"
   var client_credentials = [
      "client_id": "016c2177d2534dd1746cbcf8d0953de8d5833bcffdee5491ed993d1132b14b97",
      "client_secret": "fbfa392e93e94a66b4214ae71a23145540142b57caf74c0dbeced3581754282d",
      "grant_type": "password"
   ]
   
   static let sharedloginInstance = LoginManager()
   
   func login(email: String, password: String, completionHandler: @escaping (JSON) -> ()) {
      client_credentials["email"] = email
      client_credentials["password"] = password
      let request = Alamofire.request("http://localhost:3000\(createToken)", method: .post, parameters: client_credentials)
      
      request.responseJSON { response in
         if ((response.response?.statusCode) == 200) {
            let resource = JSON(response.result.value!)
            let authentication = UserAuthentication(
               is_sign_in: true,
               email: email,
               access_token: resource["data"]["auth"]["access_token"].stringValue,
               refresh_token: resource["data"]["auth"]["refresh_token"].stringValue,
               expires_in: resource["data"]["auth"]["expires_in"].number as! Int,
               scope: resource["data"]["auth"]["public"].stringValue
            )
            
            self.saveAuthentication(authentication)
            completionHandler(resource)
         } else {
            let error = JSON(response.result.value!)
            completionHandler(error)
         }
      }
   }
   
   func logout() {
      super.defaults.removeObject(forKey: "userAuthentication")
      super.defaults.synchronize()
   }
}
