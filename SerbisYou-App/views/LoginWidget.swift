//
//  LoginWidget.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 11/9/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol UserLoginDelegate: class {
   func userDidPressedLoginButton(_ sender: UIButton)
}

@IBDesignable class LoginWidget: UIView {
   weak var loginDelegate: UserLoginDelegate?
   var loginView: UIView!
   var nibName: String = "LoginWidget"
    
   let defaults = UserDefaults.standard
   
   @IBOutlet weak var loginButton: UIButton!
   @IBOutlet weak var email: UITextField!
   @IBOutlet weak var password: UITextField!
   @IBOutlet weak var name: UITextField!
   
   @IBAction func loginBtn(_ sender: AnyObject) {
      self.loginDelegate?.userDidPressedLoginButton(sender as! UIButton)
   }
   
   // init
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
   }
   
   func setup() {
      loginView = loadViewFromNib()
      loginView.frame = bounds
      loginView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
      
      addSubview(loginView)
      
   }
   
   func loadViewFromNib() -> UIView {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: nibName, bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
      
      return view
   }

}
