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
import GoogleMaps

class HomeViewController: UIViewController {
    @IBAction func didTapLogout(sender: AnyObject) {
      // Sign out user from Firebase
   
      try! FIRAuth.auth()!.signOut()
      
      // Sign out user from FB
      FBSDKAccessToken.setCurrentAccessToken(nil)
      self.dismissViewControllerAnimated(true, completion: nil)
      
//      let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//      let loginViewController: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginView")
//      self.presentViewController(loginViewController, animated: true, completion: nil)
    }
   
   @IBOutlet weak var currentUserLbl: UILabel!
   @IBOutlet weak var mapView: GMSMapView!
   @IBOutlet weak var addressLabel: UILabel!
    
   var locationManager: CLLocationManager!
   let defaults = NSUserDefaults.standardUserDefaults()
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        mapView.delegate = self
        
        currentUser()
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reverseGeocoderCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                
                self.addressLabel.text = lines.joinWithSeparator("\n")
                
                UIView.animateWithDuration(0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func currentUser() {
      if let email: String = defaults.objectForKey("email") as? String {
         if email.isEmpty == false {
            let splittedEmail = email.componentsSeparatedByString("@")
            currentUserLbl.text = splittedEmail[0]
         } else {
            dismissViewControllerAnimated(true, completion: nil)
         }
      }

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

extension HomeViewController: CLLocationManagerDelegate {
   
   @objc func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
      if status == .AuthorizedWhenInUse {
         locationManager.startUpdatingLocation()
         
         mapView.myLocationEnabled = true
         mapView.settings.myLocationButton = true
      }
   }
   
   func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      if let location = locations.first {
         mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
         locationManager.stopUpdatingLocation()
      }
   }
}

extension HomeViewController: GMSMapViewDelegate {
   func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
      reverseGeocoderCoordinate(position.target)
   }
}
