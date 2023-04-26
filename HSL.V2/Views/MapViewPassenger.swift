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
    
    private let mapZoomEdgeInsets = UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
    
    init(patternGeometry: String, stopsInfo: [Stop]) {
        self.patternGeometry = patternGeometry
        self.stopsInfo = stopsInfo
    }
    
    func makeCoordinator() -> MapViewPassengerCoordinator {
        MapViewPassengerCoordinator(self)
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
        print("stops in MapViewPassenger 22222: \(self.stopsInfo)")

        // show the annotations for each stops
        for stop in self.stopsInfo {
            let annotations = MKPointAnnotation()
            annotations.title = stop.name
            annotations.coordinate = CLLocationCoordinate2D(latitude: stop.lat, longitude: stop.lon)
            mapView.addAnnotation(annotations)
        }
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
      MapViewPassenger(patternGeometry: "", stopsInfo: [])
  }
}

