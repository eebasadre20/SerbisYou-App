//
//  AuthManager.swift
//  SerbisYou-App
//
//  Created by Edsil Basadre on 17/02/2017.
//  Copyright © 2017 eebasadre.co. All rights reserved.
//

import Foundation

class AuthManager {
   private let defaults = UserDefaults.standard
   private var authCredential: UserAuthentication!
   
   static let sharedAuthInstance = AuthManager()
   
   func saveAuthentication(_ userAuthentication: UserAuthentication ) {
      let savedData = NSKeyedArchiver.archivedData(withRootObject: userAuthentication)
      defaults.set(savedData, forKey: "userAuthentication")
      defaults.synchronize()
   }
   
   func loadAuthentication() -> UserAuthentication? {
      if let savedData = defaults.object(forKey: "userAuthentication") as? Data, let authentication = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? UserAuthentication {
         authCredential = authentication
      } else {
         authCredential = nil
      }
      
      return authCredential
   }
}
