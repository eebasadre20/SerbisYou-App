//
//  LoginViewController.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 11/7/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AuthenticationViewController: UIViewController, UserLoginDelegate, UserSignUpDelegate {
   let createToken: String = "/api/oauth/token"
   let defaults = UserDefaults.standard
   private var authViewModel = AuthViewModel()
   
   var client_credentials = [
            "client_id": "f03d734be207c62a5e757ca9d685a0176fc473b724ccff5a282912f8e6578f93",
            "client_secret": "1f71dc1f4bc1e6c7b92bf860e666a188d9556bb666413261549c48ad78870a6d",
            "grant_type": "password"
         ]
   
   var filePath: String {
      let manager = FileManager.default
      let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
      
      return (url?.appendingPathComponent("AuthenticationDetails").path)!
   }
   
   var authCredential: UserAuthentication!
   var signUpWidget: SignUpWidget!
   var loginWidget: LoginWidget!
   
   @IBOutlet weak var signupView: UIView!
   @IBOutlet weak var authenticationSegment: UISegmentedControl!
   @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    
    @IBAction func authenticationSegment(_ sender: AnyObject) {
        if authenticationSegment.selectedSegmentIndex == 0 {
         signUpWidget = SignUpWidget(frame: CGRect(x: 0, y: 171, width: 375, height: 247))
         signUpWidget.signUpDelegate = self
         loginWidget.removeFromSuperview()
         self.view.addSubview(signUpWidget)
        } else {
         signUpWidget.removeFromSuperview()
         loginWidget = LoginWidget(frame: CGRect(x: 0, y: 171, width: 375, height: 247))
         loginWidget.loginDelegate = self
         self.view.addSubview(loginWidget)
      }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
         signUpWidget = SignUpWidget(frame: CGRect(x: 0, y: 171, width: 375, height: 247))
         authenticationSegment.setEnabled(true, forSegmentAt: 0)
         signUpWidget.signUpDelegate = self
         self.view.addSubview(signUpWidget)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   
   // MARK: - LoginWidget Delegate

   func userDidLogin(_ status: Bool, message: String) {
      if status == true {
      } else {
         
      }
   }
   
   func userDidPressedLoginButton(_ sender: UIButton) {
      loginWidget.loginDelegate = self
      authViewModel.login(email: (loginWidget?.email.text!)!, password: (loginWidget?.password.text!)!, completionHandler: { ( response ) -> Void in
            if response["success"] == true {
               let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let homeViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeView")
               self.present(homeViewController, animated: true, completion: nil)
            } else {
               let errorAlert = UIAlertController(title: "SerbisYou", message: "Something error message", preferredStyle: UIAlertControllerStyle.alert)
               
               let okAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: { (action) -> Void in
               
                           })
               
               errorAlert.addAction(okAction)
               self.present(errorAlert, animated: true, completion: nil)
            }
            
      })
   }
   
   // MARK: - SignUpWidget Delegate
   
   func userDidSignUp(_ status: Bool, message: String) {
      if status == true {
         print(message)
      } else {
         print(message)
      }
   }
}
