//
//  SignUpWidget.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 11/8/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit
import Alamofire

protocol UserSignUpDelegate {
   func userDidSignUp(_ status: Bool, message: String)
}

@IBDesignable class SignUpWidget: UIView {
   var signUpView: UIView!
   var nibName: String = "SignUpWidget"
   var signUpDelegate: UserSignUpDelegate?
      
   @IBOutlet weak var username: UITextField!
   @IBOutlet weak var email: UITextField!
   @IBOutlet weak var password: UITextField!
   
    
   @IBAction func SignUpBtn(_ sender: AnyObject) {
      
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
      signUpView = loadViewFromNib()
      signUpView.frame = bounds
      signUpView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
      
      addSubview(signUpView)
      
   }
   
   func loadViewFromNib() -> UIView {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: nibName, bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
      
      return view
   }
}
