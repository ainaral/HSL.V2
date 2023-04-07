//
//  DriverViewModel.swift
//  HSL.V2
//
//  Created by 张嬴 on 6.4.2023.
//

import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
}

class DriverViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            // set the delegate
            self.locationManager!.delegate = self
        } else {
            print("Show an alert letting them know this is off and to go turn it on.")
        }
    }
    
    // check if app gets the permission to use location
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted likely due to parental controls")
            case .denied:
                print("Youi have denied this app location permission. Go into setting to change it.")
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(
                    center: locationManager.location!.coordinate,
                    span: MapDetails.defaultSpan)
            @unknown default:
                break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
