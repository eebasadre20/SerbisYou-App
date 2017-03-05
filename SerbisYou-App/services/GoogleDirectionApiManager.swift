//
//  GoogleDirectionApiManager.swift
//  SerbisYou-App
//
//  Created by Edsil Basadre on 05/03/2017.
//  Copyright © 2017 eebasadre.co. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import GoogleMaps

class GoogleDirection {
   public static let sharedInstance = GoogleDirection()
   
   
   func fetchMapDirection(from: Dictionary<String, CLLocationDegrees>, completionHandler: @escaping (String)->()) {
      let destinationAddressLat = 37.800221
      let destinationAddressLong = -122.452102
      let directionURL = "https://maps.googleapis.com/maps/api/directions/json?" +
         "origin=\(from["latitude"]),\(from["longitude"])&destination=\(destinationAddressLat),\(destinationAddressLong)&" +
      "key=AIzaSyBc7Q1XwLTtu1_VADOTYJod2rB37V9K7Aw"
      
      Alamofire.request(directionURL, method: .get, parameters: nil).responseJSON
         { response in
            
            if let result = response.result.value {
               let polylinePoints = JSON(result)["routes"][0]["overview_polyline"]["points"].rawString()
               let line  = polylinePoints
               
               completionHandler(line!)
            } else {
               print("Something")
            }
      }
   }
   
   func addPolyLine(mapView: GMSMapView, encodedString: String) {
      let path = GMSMutablePath(fromEncodedPath: encodedString)
      let polyline = GMSPolyline(path: path)
      polyline.strokeWidth = 8
      polyline.strokeColor = UIColor.red
      polyline.map = mapView
      
   }
}
