//
//  SocialMediaAuthenticationViewController.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 11/11/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class SocialMediaAuthenticationViewController: UIViewController, FBSDKLoginButtonDelegate {
   let loginButton = FBSDKLoginButton()

    @IBAction func AuthViaEmail(sender: AnyObject) {
        performSegueWithIdentifier("AuthenticationView", sender: nil)
    }
    @IBAction func segueSample(sender: AnyObject) {
        let fbLogin = FBSDKLoginManager()
        fbLogin.logInWithReadPermissions(["email"], fromViewController: self) { (fbResult, fbError) -> Void in
            if fbError != nil {
                print("Facebook login failed. Error \(fbError)")
                
            } else if fbResult.isCancelled {
                print("Facebook login was cancelled")
            } else {
               let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
               
               FIRAuth.auth()?.signInWithCredential(credential) { (user, error ) in
                  
                  if error != nil {
                     print("Oops! something's wrong.")
                  } else {
                     // do something here
                  }
               }

         }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.loginButton.hidden = true
      
      FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
         if let user = user {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("HomeView")
            self.presentViewController(homeViewController, animated: true, completion: nil)
         } else {
            self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            self.loginButton.delegate = self
            
            self.loginButton.hidden = false
         }
      }


        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      self.navigationController?.navigationBarHidden = true
   }
   
   override func viewWillDisappear(animated: Bool) {
      super.viewWillDisappear(animated)
      self.navigationController?.navigationBarHidden = false
   }
   
   func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
      
      self.loginButton.hidden = true
      //self.loadingSpinner.startAnimating()
      
      if(error != nil || result.isCancelled) {
         self.loginButton.hidden = false
         //self.loadingSpinner.stopAnimating()
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
