//
//  HomeViewController.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 10/28/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit

class HomeViewController: UIViewController {
    @IBAction func didTapLogout(sender: AnyObject) {
      // Sign out user from Firebase
      try! FIRAuth.auth()!.signOut()
      
      // Sign out user from FB
      FBSDKAccessToken.setCurrentAccessToken(nil)
      
      let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let loginViewController: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginView")
      self.presentViewController(loginViewController, animated: true, completion: nil)
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
