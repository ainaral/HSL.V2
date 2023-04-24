//
//  LocationManager.swift
//  HSL.V2
//
//  Created by iosdev on 17.4.2023.
//

import CoreLocation

// Requests the users location
class LocationManager: NSObject, ObservableObject{
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        // Gives the most accurate possible users location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request users location permission
        locationManager.requestWhenInUseAuthorization()
        
        // Updates the users locations after permission to so it can be accessed
        locationManager.startUpdatingLocation()
    }
}

// A function that updates the user location on the map
extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard !locations.isEmpty else { return }
        locationManager.stopUpdatingLocation()
    }
}
