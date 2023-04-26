//
//  MapViewPassenger.swift
//  HSL.V2
//
//  Created by 张嬴 on 24.4.2023.
//

import SwiftUI
import MapKit
import UIKit

struct MapViewPassenger: UIViewRepresentable {
    private var viewModel = PassengerViewModel()
    private var stopsInfo = [Stop]()
    private var patternGeometry: String
    private var selectedBus: String
    
    private let mapZoomEdgeInsets = UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
    
    init(patternGeometry: String, stopsInfo: [Stop], selectedBus: String) {
        self.patternGeometry = patternGeometry
        self.stopsInfo = stopsInfo
        self.selectedBus = selectedBus
        print("selectedbus in mapviewpassenger init \(selectedBus)")
    }
    
    func makeCoordinator() -> MapViewPassengerCoordinator {
        print("selectedbus in makecoordinator \(selectedBus)")
        print("selectedbus in makecoordinator \(self.selectedBus)")
        return MapViewPassengerCoordinator(self, selectedBus: self.selectedBus)
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(
            center: MapDetails.startingLocation,
            span: MapDetails.defaultSpan)
        mapView.region = region
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        
        // get the stops
        viewModel.fetchLocations(points: patternGeometry)
        let stopsInfo = viewModel.stops // initialize stopsInfo here

        // show the annotations for each stops
        for stop in self.stopsInfo {
            let annotations = MKPointAnnotation()
            annotations.title = stop.name
            annotations.subtitle = "Wait for bus \(selectedBus) at \(stop.name)? Pin yourself!"
            annotations.coordinate = CLLocationCoordinate2D(latitude: stop.lat, longitude: stop.lon)
            mapView.addAnnotation(annotations)
        }
        
        // update the annotations from core data
        let markers = viewModel.getMarkerByName(busName: selectedBus)
        markers.forEach { marker in
            let markerAnnotations = MKPointAnnotation()
            markerAnnotations.title = "Marker"
            markerAnnotations.coordinate = CLLocationCoordinate2D(latitude: marker.stopLat, longitude: marker.stopLon)
            mapView.addAnnotation(markerAnnotations)
        }
        
//        print("selected bus in mapviewpassenger: \(selectedBus)")
        
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

struct MapViewPassenger_Previews: PreviewProvider {
    private var viewModel = PassengerViewModel()
  static var previews: some View {
      MapViewPassenger(patternGeometry: "", stopsInfo: [], selectedBus: "")
  }
}

