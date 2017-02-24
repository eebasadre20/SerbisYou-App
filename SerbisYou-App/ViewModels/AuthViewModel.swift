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
   
   private var loginManager: LoginManager!
   private var authManager: AuthManager = AuthManager()

   
   init() {
      self.loginManager = LoginManager.sharedloginInstance
   }
   
   func login(email: String, password: String, completionHandler: @escaping (JSON) -> ()) {
      self.loginManager.login(email: email, password: password, completionHandler: { (loginResponse) in
         completionHandler(loginResponse)
      })
   }
   
}
