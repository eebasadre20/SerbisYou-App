//
//  LoginViewController.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 11/7/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class AuthenticationViewController: UIViewController, FBSDKLoginButtonDelegate, UserLoginDelegate, UserSignUpDelegate {
   var signUpWidget: SignUpWidget!
   var loginWidget: LoginWidget!
   let loginButton = FBSDKLoginButton()
   
   @IBOutlet weak var signupView: UIView!
   @IBOutlet weak var authenticationSegment: UISegmentedControl!
   @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    
    @IBAction func authenticationSegment(sender: AnyObject) {
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
      
         signUpWidget = SignUpWidget(frame: CGRect(x: 0, y: 171, width: 375, height: 247))
         authenticationSegment.setEnabled(true, forSegmentAtIndex: 0)
         signUpWidget.signUpDelegate = self
         self.view.addSubview(signUpWidget)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   
   // MARK: - LoginWidget Delegate

   func userDidLogin(status: Bool, message: String) {
      if status == true {
         self.performSegueWithIdentifier("homeView", sender: nil)
      } else {
         var errorAlert = UIAlertController(title: "SerbisYou", message: message, preferredStyle: UIAlertControllerStyle.Alert)
         
         let okAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            print("Somethinng here")
         })
         
         errorAlert.addAction(okAction)
         self.presentViewController(errorAlert, animated: true, completion: nil)
      }
   }
   
   // MARK: - SignUpWidget Delegate
   
   func userDidSignUp(status: Bool, message: String) {
      if status == true {
         print(message)
      } else {
         print(message)
      }
   }
   
   func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
      
      self.loginButton.hidden = true
      self.loadingSpinner.startAnimating()
      
      if(error != nil || result.isCancelled) {
         self.loginButton.hidden = false
         self.loadingSpinner.stopAnimating()
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
