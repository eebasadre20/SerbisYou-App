//
//  LoginWidget.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 11/9/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit

@IBDesignable class LoginWidget: UIView {

   var loginView: UIView!
   var nibName: String = "LoginWidget"
   
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
      loginView = loadViewFromNib()
      loginView.frame = bounds
      loginView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
      
      addSubview(loginView)
      
   }
   
   func loadViewFromNib() -> UIView {
      let bundle = NSBundle(forClass: self.dynamicType)
      let nib = UINib(nibName: nibName, bundle: bundle)
      let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
      
      return view
   }

}
