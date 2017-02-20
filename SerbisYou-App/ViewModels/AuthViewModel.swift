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
   
   
   let defaults = UserDefaults.standard
   var authCredential: UserAuthentication!
   
   private var loginManager: LoginManager!
   private var authManager: AuthManager = AuthManager()

   
   init() {
      self.loginManager = LoginManager.sharedInstance
   }
   
   func login(email: String, password: String, completionHandler: @escaping (JSON) -> ()) {
      self.loginManager.login(email: email, password: password, completionHandler: { (loginResponse) in
         completionHandler(loginResponse)
      })
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
