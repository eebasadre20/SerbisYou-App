//
//  HomeViewController.swift
//  SerbisYou-App
//
//  Created by Piktochart-Edsil on 10/28/16.
//  Copyright © 2016 eebasadre.co. All rights reserved.
//

import UIKit
import GoogleMaps

class IndexViewController: UIViewController {
    let loginManager = LoginManager.sharedloginInstance

    @IBAction func didTapLogout(_ sender: Any) {
        loginManager.logout()
        _ = self.navigationController?.popViewController(animated: true)
    }
   
   @IBOutlet weak var mapView: GMSMapView!
   var locationManager: CLLocationManager!
   let defaults = UserDefaults.standard
   var authCredential: UserAuthentication!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        mapView.delegate = self
      
        currentUser()
   }

   
    func reverseGeocoderCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                
//                self.addressLabel.text = lines.joined(separator: "\n")
               
                UIView.animate(withDuration: 0.25, animations: {
                    self.view.layoutIfNeeded()
                }) 
            }
        }
    }
    
    func currentUser() {
      if (self.authCredential != nil) {
        //  currentUserLbl.text = self.authCredential.Email.components(separatedBy: "@").first
      }
    }
}

extension IndexViewController: CLLocationManagerDelegate {
   
   @objc func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      if status == .authorizedWhenInUse {
         locationManager.startUpdatingLocation()
         
         mapView.isMyLocationEnabled = true
         mapView.settings.myLocationButton = true
      }
   }
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      if let location = locations.first {
         mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
         locationManager.stopUpdatingLocation()
      }
   }
}

extension IndexViewController: GMSMapViewDelegate {
   func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      reverseGeocoderCoordinate(position.target)
   }
}
