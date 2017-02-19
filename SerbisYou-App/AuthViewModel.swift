//
//  AuthViewModel.swift
//  SerbisYou-App
//
//  Created by Edsil Basadre on 17/02/2017.
//  Copyright © 2017 eebasadre.co. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthViewModel {
   let createToken: String = "/api/oauth/token"
   var client_credentials = [
      "client_id": "016c2177d2534dd1746cbcf8d0953de8d5833bcffdee5491ed993d1132b14b97",
      "client_secret": "fbfa392e93e94a66b4214ae71a23145540142b57caf74c0dbeced3581754282d",
      "grant_type": "password"
   ]
   
   let defaults = UserDefaults.standard
   var authCredential: UserAuthentication!
   
   private var loginManager: LoginManager!
   private var authManager: AuthManager = AuthManager()
   private var requestResponse: (success: Bool, message: String)?

   
   init() { }
   
   func login(email: String, password: String, completionHandler: @escaping (JSON) -> Void) {
      client_credentials["email"] = email
      client_credentials["password"] = password
      let request = Alamofire.request("http://localhost:3000\(createToken)", method: .post, parameters: client_credentials)
      
      request.responseJSON { response in
         if ((response.response?.statusCode) == 200) {
            let resource = JSON(response.result.value!)
            let authentication = UserAuthentication(
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
   
   func saveAuthentication(_ userAuthentication: UserAuthentication ) {
      let savedData = NSKeyedArchiver.archivedData(withRootObject: userAuthentication)
      defaults.set(savedData, forKey: "userAuthentication")
      defaults.synchronize()
   }
   
   func loadAuthentication() {
      if let savedData = defaults.object(forKey: "userAuthentication") as? Data {
         if let authentication = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? UserAuthentication {
            // authCredential = authentication
         }
      }
   }
   
}
