//
//  authentication.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 12/12/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import Foundation

class UserAuthentication: NSObject, NSCoding {
   struct Keys {
      static let Email = "email"
      static let AccessToken = "access_token"
      static let RefreshToken = "refresh_token"
      static let ExpiresIn = "expires_in"
      static let Scope = "scope"
   }
   
   fileprivate var _email = "";
   fileprivate var _access_token = "";
   fileprivate var _refresh_token = "";
   fileprivate var _expires_in: Int = 0
   fileprivate var _scope = ""

   override init() {}
   
   init(email: String, access_token: String, refresh_token: String, expires_in: Int, scope: String) {
      self._email = email
      self._access_token = access_token
      self._refresh_token = refresh_token
      self._expires_in = expires_in
      self._scope = scope
   }
   
   required init(coder decoder: NSCoder) {
      if let emailObj = decoder.decodeObject(forKey: Keys.Email) as? String {
         _email = emailObj
      }
      
      if let access_tokenObj = decoder.decodeObject(forKey: Keys.AccessToken) as? String {
         _access_token = access_tokenObj
      }
      
      if let refresh_tokeObj = decoder.decodeObject(forKey: Keys.RefreshToken) as? String {
         _refresh_token = refresh_tokeObj
      }
      
      if let expires_inObj = decoder.decodeObject(forKey: Keys.ExpiresIn) as? Int {
         _expires_in = expires_inObj
      }
      
      if let scopeObj = decoder.decodeObject(forKey: Keys.Scope) as? String {
         _scope = scopeObj
      }
      
   }
   
   func encode(with aCoder: NSCoder) {
      aCoder.encode(_email, forKey: Keys.Email)
      aCoder.encode(_access_token, forKey: Keys.AccessToken)
      aCoder.encode(_refresh_token, forKey: Keys.RefreshToken)
      aCoder.encode(_expires_in, forKey: Keys.ExpiresIn)
      aCoder.encode(_scope, forKey: Keys.Scope)
   }
   
   var Email: String {
      get {
         return _email;
      }
      set {
         _email = newValue;
      }
   }
   
   var AccessToken: String {
      get {
         return _access_token;
      }
      set {
         _access_token = newValue;
      }
   }
   
   var RefreshToken: String {
      get {
         return _refresh_token;
      }
      set {
         _refresh_token = newValue;
      }
   }
   
   var ExpiresIn: Int {
      get {
         return _expires_in;
      }
      set {
         _expires_in = newValue;
      }
   }
   
   var Scope: String {
      get {
         return _scope;
      }
      set {
         _scope = newValue;
      }
   }
}
