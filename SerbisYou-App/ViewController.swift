//
//  ViewController.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 10/27/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
   let loginButton = FBSDKLoginButton()

    @IBOutlet weak var LoadinSpinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.hidden = true

        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
          if let user = user {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("HomeView")
            self.presentViewController(homeViewController, animated: true, completion: nil)
          } else {
            self.loginButton.center = self.view!.center
            self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            self.loginButton.delegate = self
            self.view!.addSubview(self.loginButton)

            self.loginButton.hidden = false
          }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


   func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {

    self.loginButton.hidden = true
    self.LoadinSpinner.startAnimating()

    if(error != nil || result.isCancelled) {
      self.loginButton.hidden = false
      self.LoadinSpinner.stopAnimating()
    } else {
      let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)

      FIRAuth.auth()?.signInWithCredential(credential) { (user, error ) in
        print( "Sign in using firebase" )
      }

    }

  }

   func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
      print("User Logout")
   }
}

