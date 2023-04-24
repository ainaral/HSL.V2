//
//  PassengerMapRepresentable.swift
//  HSL.V2
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI
import MapKit

struct PassengerMapRepresentable: UIViewRepresentable {
    private let viewModel = PassengerViewModel()
    private var busName: String
    
    // UIKit Mapview component
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    // Makes the map view and configured so as to be represented in Swift UI
    func makeUIView(context: Context) -> some UIView {
        // set the mapView delegate protocol to context coordinator
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    
    private let mapZoomEdgeInsets = UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
    
    init(busName: String) {
        self.busName = busName
        viewModel.fetchData(queryType: .routeByBus(search: busName))
    }
    
    func makeCoordinator() -> MapViewCoordinatorPassenger {
        MapViewCoordinatorPassenger(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateOverlays(from: uiView)
    }
    
    private func updateOverlays(from mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(
            coordinates: viewModel.locations,
            count: viewModel.locations.count)
        mapView.addOverlay(polyline)
        setMapZoomArea(map: mapView, polyline: polyline, edgeInsets: mapZoomEdgeInsets, animated: true)
    }
    
    private func setMapZoomArea(map: MKMapView, polyline: MKPolyline, edgeInsets: UIEdgeInsets, animated: Bool = false) {
        map.setVisibleMapRect(polyline.boundingMapRect, edgePadding: edgeInsets, animated: animated)
    }
}

extension PassengerMapRepresentable {
    
    // Provies functionalities that allow features on the map view
    class MapCoordinator: NSObject, MKMapViewDelegate{
        
        // Properties
        // Communication between Map Coordinator and PassengerMapRepresentable
        let parent: PassengerMapRepresentable
        
        
        // Lifecycle
        init(parent: PassengerMapRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MKMapViewDelegate
        // Tells the delegate that the location of the user was updated
        // Displays user's location
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            // self.userLocationCoordinate = userLocation.coordinate
            let region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            parent.mapView.setRegion(region, animated: true)
            
        }
        
    }
    
}


