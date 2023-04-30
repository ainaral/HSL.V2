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
    
    // customize the annotation for stops
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKMarkerAnnotationView?
        // Check if the annotation is a point annotation (i.e. not the user's location)
        guard let annotation = annotation as? MKPointAnnotation else {
            return nil
        }
        
        // give the red pin annotation if user mark the stop
        if annotation.title == "Passenger" {
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "MarkerAnnotation") as? MKMarkerAnnotationView
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MarkerAnnotation")
                annotationView?.canShowCallout = true
            }
            
            // Customize the red pin annotation
            annotationView?.markerTintColor = UIColor.red
            annotationView?.glyphImage = UIImage(systemName: "pin")
            annotationView?.selectedGlyphImage = UIImage(systemName: "pin")
            annotationView?.glyphTintColor = UIColor.white
            annotationView?.glyphTintColor = UIColor.white

            

        } else {
            // give the blue bus annotation if user didn't mark the stop
            let reuseIdentifier = "stopAnnotation"
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKMarkerAnnotationView
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)

                // show the call out
                annotationView?.canShowCallout = true

                // customize the call out layout
                let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                rightButton.setImage(UIImage(systemName: "pin"), for: .normal)
                annotationView?.rightCalloutAccessoryView = rightButton
            }

            // Customize the blue bus annotation
            annotationView?.markerTintColor = UIColor.clear
            annotationView?.glyphImage = UIImage(systemName: "bus")
            annotationView?.selectedGlyphImage = UIImage(systemName: "bus")
            annotationView?.glyphTintColor = UIColor.blue
        }
        
        return annotationView
    }
    
}
