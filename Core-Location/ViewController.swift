//
//  ViewController.swift
//  Core-Location
//
//  Created by Apple on 09/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import CoreLocation
import  MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {

    
    let locationManger = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getlocation(_ sender: Any) {
        
       let status = CLLocationManager.authorizationStatus()
        
        
        if status == .notDetermined{
        
        locationManger.requestWhenInUseAuthorization()
            return
        
        }
        
        
        if status == .denied || status == .restricted{
        
        let alert = UIAlertController(title: "Request To Enable location service", message: "Please enable location service", preferredStyle: .alert)
            
          
            let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okaction)
   
        
        }
             locationManger.delegate = self
        locationManger.startUpdatingLocation()
        
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let newLocation = locations.last else { return }
        
        let latitude = Double(newLocation.coordinate.latitude)
        let longitude = Double(newLocation.coordinate.longitude)
        
        let latString = (latitude < 0) ? "S" : "N"
        let lonString = (longitude < 0) ? "W" : "E"
        
        let coords = "\(latString) \(latitude) \(lonString) \(longitude)"
        
       // print("fdskjnfs\(coords)")

        let currentlocation = locations.last
        //print("current location \(currentlocation)")
        
        let geoCoder = CLGeocoder()
        //let location = CLLocation(latitude: , longitude: current.longitude)
        
        let loc = CLLocation(latitude:newLocation.coordinate.latitude , longitude: newLocation.coordinate.longitude)
        geoCoder.reverseGeocodeLocation(loc)
        {
            (placemarks, error) -> Void in
            
            let placeArray = placemarks as [CLPlacemark]!
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary)
            
            // Location name
            if let locationName = placeMark.addressDictionary?["Name"] as? NSString
            {
                print(locationName)
            }
            
            // Street address
            if let street = placeMark.addressDictionary?["Thoroughfare"] as? NSString
            {
                print(street)
            }
            
            // City
            if let city = placeMark.addressDictionary?["City"] as? NSString
            {
                print(city)
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary?["ZIP"] as? NSString
            {
                print(zip)
            }
            
            // Country
            if let country = placeMark.addressDictionary?["Country"] as? NSString
            {
                print(country)
            }
        }

        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    
    
    
    

}

