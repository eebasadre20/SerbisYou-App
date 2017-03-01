//
//  FBUser.swift
//  SerbisYou-App
//
//  Created by Edsil Basadre on 01/03/2017.
//  Copyright © 2017 eebasadre.co. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class FBUser: NSObject {
   var id: Int
   var email: String
   
   init(id: Int, email: String) {
      self.id = id
      self.email = email
   }
   
   
}

class FBUserData {
   var fBUser: FBUser!
   
   func get(completionHandler: @escaping (_ user: FBUser?, _ error: Error?) -> ()) {
      FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, email"]).start { (connection, response, error) in
         
         guard error == nil else {
            completionHandler(nil, error!)
            return
         }
         
         guard let userInfo = response as? [String: String], let userId = Int(userInfo["id"]!), let email = userInfo["email"] else {
            completionHandler(nil, error!)
            return
         }
         
         self.fBUser = FBUser(id: userId, email: email)
         completionHandler(self.fBUser!, nil)
      }
   }

}
 
