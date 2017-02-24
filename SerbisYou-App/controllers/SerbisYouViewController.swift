//
//  SocialMediaAuthenticationViewController.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 11/11/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit

class SerbisYouViewController: UIViewController {
   
   var authCredential: UserAuthentication!

    @IBAction func AuthViaEmail(_ sender: AnyObject) {
        performSegue(withIdentifier: "AuthView", sender: nil)
    }
    @IBAction func segueSample(_ sender: AnyObject) {
        
    }
   
    override func viewDidLoad() {
      super.viewDidLoad()
      if let auth: UserAuthentication = AuthManager.sharedAuthInstance.loadAuthentication() {
         if auth.IsSignIn {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "IndexView")
            self.present(homeViewController, animated: true, completion: nil)
         }
      }
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.navigationController?.isNavigationBarHidden = true
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      self.navigationController?.isNavigationBarHidden = false
   }
}
