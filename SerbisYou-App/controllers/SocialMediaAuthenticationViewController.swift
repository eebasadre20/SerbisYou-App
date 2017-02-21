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
      authCredential = Session.sharedInstance.authSetup()
      
      if authCredential != nil {
         let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let homeViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeView")
         self.present(homeViewController, animated: true, completion: nil)
      }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.navigationController?.isNavigationBarHidden = true
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      self.navigationController?.isNavigationBarHidden = false
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
