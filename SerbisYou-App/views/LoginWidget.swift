//
//  LoginWidget.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 11/9/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit
import FirebaseAuth
import Alamofire

protocol UserLoginDelegate {
   func userDidLogin(status: Bool, message: String)
}

@IBDesignable class LoginWidget: UIView {
   
   // request create token
   let createToken: String = "/api/oauth/token"

   var loginDelegate: UserLoginDelegate?
   var loginView: UIView!
   var nibName: String = "LoginWidget"
   
   @IBOutlet weak var email: UITextField!
   @IBOutlet weak var password: UITextField!
   @IBOutlet weak var name: UITextField!
   @IBAction func loginBtn(sender: AnyObject) {
      
      
      let client_credentials = [
         "client_id": "f03d734be207c62a5e757ca9d685a0176fc473b724ccff5a282912f8e6578f93",
         "client_secret": "1f71dc1f4bc1e6c7b92bf860e666a188d9556bb666413261549c48ad78870a6d",
         "grant_type": "password",
         "email": email.text!,
         "password": password.text!
      ]
      
      let request = Alamofire.request(.POST, "http://localhost:3000\(createToken)", parameters: client_credentials)
      request.responseJSON { (response) -> Void in
         if response.result.isSuccess {
            self.loginDelegate?.userDidLogin(true, message: "Welcome, \(self.email.text)")
         } else {
            
         }
      }
      
//      FIRAuth.auth()?.signInWithEmail(email.text!, password: password.text!, completion: { (user, error) -> Void in
//         if user != nil {
//            self.loginDelegate?.userDidLogin(true, message: "Welcome, \(self.email.text)")
//         } else {
//            self.loginDelegate?.userDidLogin(false, message: (error?.localizedDescription)!)
//         }
//      })
   }
   // init
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      // set anything that uses the view or visible bounds
      setup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
      // setup
      setup()
   }
   
   func setup() {
      loginView = loadViewFromNib()
      loginView.frame = bounds
      loginView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
      
      addSubview(loginView)
      
   }
   
   func loadViewFromNib() -> UIView {
      let bundle = NSBundle(forClass: self.dynamicType)
      let nib = UINib(nibName: nibName, bundle: bundle)
      let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
      
      return view
   }

}
