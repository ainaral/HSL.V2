//
//  DriverViewModel.swift
//  HSL.V2
//
//  Created by 张嬴 on 6.4.2023.
//

import MapKit
import SwiftUI
import Polyline

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
}

class DriverViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan)
    // get the instance of RouteModel
    @Published var routes = [Route]()
    
    // get the instance of BusModel
    @Published var buses = [Bus]()
    
    // get the searchText from the searchBar
    @Published var searchText: String = ""
    
    // Show list of bus
    @Published var showBusList: Bool = false
    
    var locationManager: CLLocationManager?
    
    // get the polyline
    @Published var locations = [CLLocationCoordinate2D]()
    
    // get the patternGeometry
    @Published var patternGeometry: String = ""
    
    // get the stops
    @Published var stops = [Stop]()
    
    // current location
    @Published var currentLocation: CLLocationCoordinate2D?
    
    // check if the location services is enabled
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
    
    // current location
//    func setLocationOnMap(mapView: MKMapView) {
//        if let location = currentLocation {
//            let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
//            mapView.setRegion(region, animated: true)
//
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = location
//            mapView.addAnnotation(annotation)
//        }
//    }
}

extension DriverViewModel {
    
    enum QueryType {
        case busesByNumber(search: String)
        case routeByBus(search: String)
    }
    
    // fetch data by different query
    func fetchData(queryType: QueryType) {
        guard let url = URL(string: "https://api.digitransit.fi/routing/v1/routers/hsl/index/graphql?digitransit-subscription-key=107e15984f284c95b2a5c128295609d7") else { return }
        
        var query = ""
        switch queryType {
        case .busesByNumber(let search):
            query = queryBus(search: search)
        case .routeByBus(let search):
            query = queryRoute(search: search)
        }
        print(query)
        let jsonData = Data(query.utf8)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/graphql", forHTTPHeaderField: "Content-Type")
        
        // to gegt the data
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = json as? [String: Any], let dataDict = jsonDict["data"] as? [String: Any], let routesArray = dataDict["routes"] as? [[String: Any]] {
                        let routesData = try JSONSerialization.data(withJSONObject: routesArray, options: [])
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        switch queryType {
                        case .busesByNumber:
                            let buses = try decoder.decode([Bus].self, from: routesData)
                            DispatchQueue.main.async {
                                self.buses = buses
                                if buses.isEmpty {
                                    self.showBusList = false
                                } else {
                                    self.showBusList = true
                                }
                                print(self.buses)
                            }
                        case .routeByBus:
                            let routes = try decoder.decode([Route].self, from: routesData)
                            DispatchQueue.main.async {
                                // get routes, patternGeometry for polyline, stops for annotations
                                self.routes = routes
                                self.patternGeometry = routes[0].patterns[0].patternGeometry.points
                                self.stops = routes[0].stops
                                self.fetchLocations()
                            }
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
    
    // the query to fetch the route basic info
    func queryRoute(search: String) -> String {
        let query1 = "{ routes(name: \""
        let query2 = search
        let query3 = "\", transportModes: BUS) { gtfsId shortName stops { name lat lon } patterns { name patternGeometry { points } } } }"
        return query1 + query2 + query3
    }
    
    // the query to fetch the bus basic info
    func queryBus(search: String) -> String {
        let query1 = "{ routes(name: \""
        let query2 = search
        let query3 = "\", transportModes: BUS) { gtfsId shortName longName mode } }"
        return query1 + query2 + query3
    }
}

extension DriverViewModel {
    // to load
    func load() {
        fetchData(queryType: .routeByBus(search: searchText))
    }
    
    // decode the patternGeometry to draw the polyline
    private func fetchLocations() {
        let polyline = Polyline(encodedPolyline: patternGeometry, encodedLevels: "BA")
        guard let decodedLocations = polyline.locations else { return }
        locations = decodedLocations.map { CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)}
    }
}

extension DriverViewModel {
    
    func getMarkerByName(busName: String) -> [Marker] {
        CoreDataManager.shared.getMarkersByBus(busName: busName)
    }
}
