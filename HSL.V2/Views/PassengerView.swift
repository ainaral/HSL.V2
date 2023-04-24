//
//  PassengerView.swift
//  HSL.V2
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI
import MapKit

// Define a struct for a City object with an id, name, and coordinates
struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// Define the PassangerView which contains a MapView
struct PassengerView: View {
    
    // State variable to toggle the search screen
    @State var showSearchScreen: Bool = true
    
    // State variable for the region displayed in the MapView
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.172783, longitude: 24.9362295), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    // An array of City objects to display as annotations on the MapView
    let annotations = [
        City(name: "Helsinki", coordinate: CLLocationCoordinate2D(latitude: 60.167109, longitude: 24.9330739)),
        City(name: "Espoo", coordinate: CLLocationCoordinate2D(latitude: 60.2043106, longitude: 24.6544416)),
    ]
    
    // The body of the PassangerView, which displays a MapView
    var body: some View {
        // A ZStack to layer the MapView and the search screen on top of each other
        ZStack(alignment: .bottom){
            
            // A GeometryReader to size the MapView
            GeometryReader { geometry in
                
                // The MapView displaying the annotations and the region
                Map(coordinateRegion: $region, annotationItems: annotations) {
                    MapMarker(coordinate: $0.coordinate)
                }
                .ignoresSafeArea()
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            
            // The search screen displayed as a pop-up
            SearchPassengerView(showSearchScreen: $showSearchScreen)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .statusBar(hidden: true)
        .onAppear {
            showSearchScreen = true
        }
    }
}

struct PassengerView_Previews: PreviewProvider {
    static var previews: some View {
        PassengerView()
    }
}
