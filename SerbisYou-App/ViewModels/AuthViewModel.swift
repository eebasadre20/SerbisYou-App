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
import FBSDKLoginKit

class AuthViewModel {
   
   private var loginManager: LoginManager!
   private var authManager: AuthManager = AuthManager()
   private var fbUserData: FBUserData = FBUserData()

   
   init() {
      self.loginManager = LoginManager.sharedloginInstance
   }
   
   func login(email: String, password: String, completionHandler: @escaping (JSON) -> ()) {
      self.loginManager.login(email: email, password: password, completionHandler: { (loginResponse) in
         completionHandler(loginResponse)
      })
   }
   
   func loginWithFacebook(controller: UIViewController, completionHandler: @escaping (_ response: JSON?, _ errorResponse: Error?)-> ()) {

      loginManager.loginWithFacebook(controller: controller) { (response, error) in
         guard error == nil else {
            completionHandler(nil, error!)
            return
         }
         
         completionHandler(response, nil)
      }
   }

   
}
