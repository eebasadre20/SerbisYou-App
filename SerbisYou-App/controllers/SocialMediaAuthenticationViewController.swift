//
//  SocialMediaAuthenticationViewController.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 11/11/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit

class SocialMediaAuthenticationViewController: UIViewController {
   
   var authCredential: UserAuthentication!

    @IBAction func AuthViaEmail(_ sender: AnyObject) {
        performSegue(withIdentifier: "AuthenticationView", sender: nil)
    }
    @IBAction func segueSample(_ sender: AnyObject) {
        
    }
   
    override func viewDidLoad() {
      super.viewDidLoad()
      if let auth: UserAuthentication = Session.sharedInstance.loadAuthentication() {
         if !auth.Email.isEmpty {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeView")
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
