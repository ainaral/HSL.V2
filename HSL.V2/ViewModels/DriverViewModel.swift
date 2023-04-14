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
    @Published var items = [Route]()
    
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
    
    // fetch the stop info from API
    func fetchStop() {
        guard let url = URL(string: "https://api.digitransit.fi/routing/v1/routers/hsl/index/graphql?digitransit-subscription-key=107e15984f284c95b2a5c128295609d7") else { return }
        
        let query = "{ routes(name: \"532\", transportModes: BUS) { gtfsId shortName longName trips { stoptimes { stop { name lat lon } realtimeArrival } } } }"
        let jsonData = Data(query.utf8)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/graphql", forHTTPHeaderField: "Content-Type")
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = json as? [String: Any], let dataDict = jsonDict["data"] as? [String: Any], let routesArray = dataDict["routes"] as? [[String: Any]] {
                        let routesData = try JSONSerialization.data(withJSONObject: routesArray, options: [])
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let routes = try decoder.decode([Route].self, from: routesData)
                        DispatchQueue.main.async {
                            self.items = routes
                        }
                    }
                } else {
                    print("no data")
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
