
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
import FBSDKLoginKit

enum GrantType: String {
   case password = "password"
   case assertion = "assertion"
   case client_credentials = "client_credentials"
}

class LoginManager {
   
   // TODO: Need to be refactor
   //       1. Move credentials in Keychain
   //       2. Refactor Alamofire request
   //       3. Review Singleton implementation
   //       4. Parameters and Credentials move to proper class
   
   let createToken: String = "/api/oauth/token"
   var client_credentials = [
      "client_id": "016c2177d2534dd1746cbcf8d0953de8d5833bcffdee5491ed993d1132b14b97",
      "client_secret": "fbfa392e93e94a66b4214ae71a23145540142b57caf74c0dbeced3581754282d",
      "grant_type": ""
   ]
   
   var headers = [
      "client_id": "016c2177d2534dd1746cbcf8d0953de8d5833bcffdee5491ed993d1132b14b97",
      "client_secret": "fbfa392e93e94a66b4214ae71a23145540142b57caf74c0dbeced3581754282d",
      "grant_type": ""
   ]
   

   
   static let sharedloginInstance = LoginManager()
   private let defaults = UserDefaults.standard
   private let authManager = AuthManager.sharedAuthInstance
   private var fbUserData: FBUserData = FBUserData()
   
   func login(email: String, password: String, completionHandler: @escaping (JSON) -> ()) {
      client_credentials["email"] = email
      client_credentials["password"] = password
      client_credentials["grant_type"] = GrantType.client_credentials.rawValue
      
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
            
            self.authManager.saveAuthentication(authentication)
            completionHandler(resource)
         } else {
            let error = JSON(response.result.value!)
            completionHandler(error)
         }
      }
   }
   
   func loginWithFacebook(controller: UIViewController, completionHandler: @escaping (_ response: JSON?, _ errorResponse: Error?)-> ()) {
      
      FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: controller) { (response, error) in
         guard error == nil else {
            completionHandler(nil, error!)
            return
         }
         
         if response?.grantedPermissions != nil {
            self.fbUserData.get() { (user, error) in
               guard error == nil else {
                  completionHandler(nil, error!)
                  return
               }
            
               self.FBLoginRequest(user: user!, completionHandler: { (response) in
                  if response["success"] == true {
                     completionHandler(response, nil)
                  } else {
                     completionHandler(response, nil)
                  }
               })
            }
         }
      }
   }

   
   func logout() {
      defaults.removeObject(forKey: "userAuthentication")
      defaults.synchronize()
   }
   
   private func FBLoginRequest(user: FBUser, completionHandler: @escaping (JSON) -> ()) {
      headers["grant_type"] = GrantType.assertion.rawValue
      
      let request = Alamofire.request("http://localhost:3000\(createToken)", method: .post, parameters: ["email": user.email, "password": "", "provider": "facebook","id": user.id], headers: headers)
      
      request.responseJSON { response in
         
         if ((response.response?.statusCode) == 200) {
            let resource = JSON(response.result.value!)
            let authentication = UserAuthentication(
               is_sign_in: true,
               email: user.email,
               access_token: resource["data"]["auth"]["access_token"].stringValue,
               refresh_token: resource["data"]["auth"]["refresh_token"].stringValue,
               expires_in: resource["data"]["auth"]["expires_in"].number as! Int,
               scope: resource["data"]["auth"]["public"].stringValue
            )
            
            self.authManager.saveAuthentication(authentication)
            completionHandler(resource)
         } else {
            let error = JSON(response.result.value!)
            completionHandler(error)
         }
      }

   }
   
}
