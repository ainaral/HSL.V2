//
//  MapViewCoordinator.swift
//  HSL.V2
//
//  Created by 张嬴 on 18.4.2023.
//

import MapKit

final class MapViewCoordinator: NSObject, MKMapViewDelegate {
    private let map: MapView
  
    init(_ control: MapView) {
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
        renderer.strokeColor = .blue
        renderer.lineWidth = 3.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Check if the annotation is a point annotation (i.e. not the user's location)
        guard let annotation = annotation as? MKPointAnnotation else {
            return nil
        }
        
        // Dequeue a reusable annotation view or create a new one
        let reuseIdentifier = "stopAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        
        // Customize the annotation view
        annotationView?.markerTintColor = UIColor.clear
        annotationView?.glyphImage = UIImage(systemName: "bus")
        annotationView?.selectedGlyphImage = UIImage(systemName: "bus")
        annotationView?.glyphTintColor = UIColor.blue
        
        return annotationView
    }
}
