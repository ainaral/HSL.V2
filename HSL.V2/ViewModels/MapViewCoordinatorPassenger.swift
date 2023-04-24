//
//  MapViewCoordinatorPassenger.swift
//  HSL.V2
//
//  Created by iosdev on 23.4.2023.
//

import MapKit

final class MapViewCoordinatorPassenger: NSObject, MKMapViewDelegate {
  private let map: PassengerMapRepresentable
  
  init(_ control: PassengerMapRepresentable) {
    self.map = control
  }
  
  func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
    if let annotationView = views.first, let annotation = annotationView.annotation {
      if annotation is MKUserLocation {
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
      }
    }
  }

  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let renderer = MKPolylineRenderer(overlay: overlay)
      renderer.strokeColor = .systemBlue
      renderer.lineWidth = 6
    return renderer
  }
}
