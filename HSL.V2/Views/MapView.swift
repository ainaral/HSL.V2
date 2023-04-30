//
//  MapView.swift
//  HSL.V2
//
//  Created by 张嬴 on 18.4.2023.
//

import SwiftUI
import MapKit
import UIKit

struct MapView: UIViewRepresentable {
    private var viewModel = DriverViewModel()
    private var busName: String
    private var stops = [Stop]()
    private var selectedBus: String
    
    private let mapZoomEdgeInsets = UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
    
    init(busName: String, selectedBus: String) {
        self.busName = busName
        self.selectedBus = selectedBus
        viewModel.fetchData(queryType: .routeByBus(search: busName))
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(
            center: MapDetails.startingLocation,
            span: MapDetails.defaultSpan)
        mapView.region = region
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        
        // update the annotations from core data
        let markers = viewModel.getMarkerByName(busName: selectedBus)
        
        markers.forEach { marker in
            print("marker in mapview get specific markers: \(String(describing: marker.busName)) \(marker.stopLat) \(marker.stopLon)")
            let markerAnnotations = MKPointAnnotation()
            markerAnnotations.title = "Passenger"
            markerAnnotations.coordinate = CLLocationCoordinate2D(latitude: marker.stopLat, longitude: marker.stopLon)
            mapView.addAnnotation(markerAnnotations)
        }
        return mapView
    }
    
    // updateUIView to add overlay
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateOverlays(from: uiView)
    }
    
    // updateOverlays to add polyline
    private func updateOverlays(from mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(
            coordinates: viewModel.locations,
            count: viewModel.locations.count)
        mapView.addOverlay(polyline)
        setMapZoomArea(map: mapView, polyline: polyline, edgeInsets: mapZoomEdgeInsets, animated: true)
    }
    
    // to set the map zoom area
    private func setMapZoomArea(map: MKMapView, polyline: MKPolyline, edgeInsets: UIEdgeInsets, animated: Bool = false) {
        map.setVisibleMapRect(polyline.boundingMapRect, edgePadding: edgeInsets, animated: animated)
    }
}

struct MapView_Previews: PreviewProvider {
    private var viewModel = DriverViewModel()
  static var previews: some View {
      MapView(busName: "", selectedBus: "")
  }
}
