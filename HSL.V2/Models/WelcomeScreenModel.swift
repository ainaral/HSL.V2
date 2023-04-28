//
//  WelcomeScreenModel.swift
//  HSL.V2
//
//  Created by Yana Krylova on 20.4.2023.
//

import Foundation
import CoreLocation
import Combine

class WelcomeScreenModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    private var cancellable: AnyCancellable?
    static let isFirstLaunchKey = "isFirstLaunch"
    @Published var enableLocation = false
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        enableLocation = status == .authorizedWhenInUse
    }
}
